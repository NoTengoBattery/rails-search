class BingSearchService
  include Searchable

  MAPPING = {
    extract: :snippet,
    headline: :name,
    url: :url
  }

  attr_reader :schema

  def initialize(args) = @schema = search(self.class.name, args)

  def schema_flatten(schema)
    schema["webPages"]["value"].each do |element|
      element[:provider] = self.class.name
      element[:map] = MAPPING
    end
  end

  private

  def build_uri(query)
    uri = URI.parse("https://bing-web-search1.p.rapidapi.com/search")
    uri.query = "q=#{CGI.escape(query)}"
    uri
  end

  def make_request(uri)
    RestClient.get(uri.to_s,
      x_bingapis_sdk: "true",
      x_rapidapi_host: "bing-web-search1.p.rapidapi.com",
      x_rapidapi_key: Rails.application.credentials.rapidapi[:key])
  end
end
