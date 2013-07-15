require "httmultiparty"
# require "tempfile"


class Csvio
  class Template
    attr_accessor :identifier, :url

    def initialize(attrs = {})
      @identifier = attrs["identifier"]
      @url        = attrs["url"]
    end
  end
end

class CsvioResponse
  attr_accessor :uuid, :url, :response

  def initialize(uuid, url, response)
    @uuid = uuid
    @url  = url
    @response = response
  end

  def inspect
    "#<CsvioResponse:#{object_id} uuid: #{@uuid} url: #{@url}>"
  end

  def ==(other)
    other === self or other.identifier == @identifier
  end

end

class Csvio
  include HTTMultiParty

  base_uri 'http://csv.io'

  TEMPLATES_PATH = '/api/v1/templates.json'.freeze
  EXPORT_PATH = '/api/v1/export'.freeze

  def initialize(api_key = nil)
    api_key ||= ENV["CSVIO_TOKEN"]
    raise("No API key provided") unless api_key
    @auth = {:username => api_key}
  end

  def templates
    response = self.class.get(TEMPLATES_PATH, :basic_auth => @auth)

    data = response.parsed_response
    if data.is_a?(Array)
      data.map do |hsh|
        Template.new(hsh)
      end
    else
      data
    end
  end

  def create(template, options = {})
    template = template.identifier if template.respond_to?(:identifier)
    options = {
      :template => template,
      :async => true
    }.merge(options)

    http_opts = {
      :body => options,
      :basic_auth => @auth
    }

    response = self.class.post(EXPORT_PATH, http_opts)

    if response.success? && options[:async]
      parsed = response.parsed_response
      CsvioResponse.new(parsed["uuid"], parsed["url"], response)
    else
      tmp = Tempfile.new("csvio")
      tmp.write response.body
      tmp.rewind
      tmp
    end
  end
end
