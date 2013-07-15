require File.expand_path(File.dirname(__FILE__) + "/test_helper")


class ListTemplatesTest < MiniTest::Spec
  describe "list_templates" do
    before do
      ENV["CSVIO_TOKEN"] = 'API KEY'
    end

    it "should give me a valid response" do
      stub_http_response_with("templates.json", :get, 200,  :content_type => 'application/json')
      templates = Csvio.new.templates

      assert_equal templates[0].identifier, "stockchart"
      assert_equal templates[0].url, "http://csv.io/templates/1.json"

      assert_equal templates[1].identifier, "template-2"
      assert_equal templates[1].url, "http://csv.io/templates/2.json"
    end

  end
end

