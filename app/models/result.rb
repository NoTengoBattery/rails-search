class Result
  include ActiveModel::Callbacks
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON

  attr_accessor :headline, :mappings, :url, :extract

  validates :extract, :headline, :mappings, :url, presence: true

  def attributes
    {"extract" => nil,
     "headline" => nil,
     "url" => nil}
  end
end
