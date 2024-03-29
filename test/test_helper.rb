require 'rubygems'

gem 'minitest'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'
require 'webmock/minitest'
require "csvio"

class MiniTest::Spec
  def stub_http_response_with(filename, method = :any, status = 200, headers = nil)
    format = filename.split('.').last.intern
    data = file_fixture(filename)

    stub_request(method, /csv\.io/).to_return(:body => data, :status => status, :headers => headers)
  end

  def file_fixture(filename)
    open(File.join(File.dirname(__FILE__), "fixtures", "#{filename.to_s}")).read.strip
  end
end
