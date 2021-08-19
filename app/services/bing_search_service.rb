class BingSearchService
  MAPPING = {
    extract: :snippet,
    headline: :name,
    url: :url
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
    # Sorting by the digest of the result will lead to a random yet deterministic
    # sorting, allowing the seamless mixture and truncation of the results.
    schema["webPages"]["value"].sort_by do |element|
      Digest::MD5.hexdigest(Marshal.dump(element))
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
