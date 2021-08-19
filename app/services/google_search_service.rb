class GoogleSearchService
  MAPPING = {
    extract: :description,
    headline: :title,
    url: :link
  }

  attr_reader :schema

  def initialize(args)
    @schema = Rails.cache.fetch(CacheKey.gen!(args), expires_in: 12.hours) do
      args = ActiveSupport::HashWithIndifferentAccess.new(args)
      uri = build_uri(args[:q])
      response = JSON.parse(make_request(uri).body)
      schema_flatten(response)
    end
  end

  def schema_flatten(schema)
    schema["results"]
  end

  private

  def build_uri(query)
    uri = URI.parse("https://google-search3.p.rapidapi.com/api/v1/search")
    uri.path += "/q=#{CGI.escape(query)}"
    uri
  end

  def make_request(uri)
    RestClient.get(uri.to_s,
      x_rapidapi_key: Rails.application.credentials.rapidapi[:key],
      x_rapidapi_host: "google-search3.p.rapidapi.com")
  end
end
