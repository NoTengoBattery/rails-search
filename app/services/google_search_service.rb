class GoogleSearchService
  include Searchable

  MAPPING = {
    extract: :description,
    headline: :title,
    url: :link
  }

  attr_reader :schema

  def initialize(args) = @schema = search(self.class.name, args)

  def schema_flatten(schema)
    schema["results"].each do |element|
      element[:provider] = self.class.name
      element[:map] = MAPPING
    end
  end

  private

  def build_uri(query)
    uri = URI.parse("https://google-search3.p.rapidapi.com/api/v1/search")
    uri.path += "/q=#{CGI.escape(query)}"
    uri
  end

  def make_request(uri)
    RestClient.get(uri.to_s,
      x_rapidapi_host: "google-search3.p.rapidapi.com",
      x_rapidapi_key: Rails.application.credentials.rapidapi[:key])
  end
end
