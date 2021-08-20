class Result
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations::Callbacks

  # For simplicity reasons, I will leave it this way.
  before_validation :map_properties unless Rails.env.test?

  attr_accessor :extract, :headline, :mappings, :provider, :url

  validates :extract, :headline, :mappings, :provider, :url, presence: true

  def initialize(schema = {})
    @schema = schema
  end

  def attributes
    {"extract" => nil,
     "headline" => nil,
     "provider" => nil,
     "url" => nil}
  end

  private

  # The problem is simple enough that unpacking this way makes sense
  def map_properties
    @mappings = @schema["map"]
    @extract = @schema[@mappings[:extract]]
    @headline = @schema[@mappings[:headline]]
    @provider = @schema[:provider]
    @url = @schema[@mappings[:url]]
  end
end
