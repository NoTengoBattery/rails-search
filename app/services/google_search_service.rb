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
      schema_flatten(ActiveSupport::HashWithIndifferentAccess.new(response))
    end
  end

  def schema_flatten(schema)
    # Sorting by the digest of the result will lead to a random yet deterministic
    # sorting, allowing the seamless mixture and truncation of the results.
    schema["results"].sort_by do |element|
      element[:provider] = "google"
      element[:map] = MAPPING
      Digest::MD5.hexdigest(Marshal.dump(element))
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
