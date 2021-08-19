class Result
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations::Callbacks

  after_validation :map_properties

  attr_accessor :headline, :mappings, :url, :extract

  validates :extract, :headline, :mappings, :url, presence: true

  def attributes
    {"extract" => nil,
     "headline" => nil,
     "url" => nil}
  end

  private

  def map_properties
  end
end
