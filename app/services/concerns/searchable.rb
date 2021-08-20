module Searchable
  def search(who, args)
    # Caching prevents making useless requests and depleting the free-tier API calls
    Rails.cache.fetch(CacheKey.gen!(who, args), expires_in: 12.hours) do
      args = ActiveSupport::HashWithIndifferentAccess.new(args)
      uri = build_uri(args[:q])
      response = JSON.parse(make_request(uri).body)
      schema_flatten(ActiveSupport::HashWithIndifferentAccess.new(response))
    end
  end
end
