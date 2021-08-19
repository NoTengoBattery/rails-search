# This is a recordless model (i.e. does not exist in a database)

class Search
  ENGINES = ["bing", "both", "google"]

  include ActiveModel::Model
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations::Callbacks

  after_validation :perform_search

  attr_accessor :engine, :search, :results

  validates :engine, :search, presence: true
  validates :engine, inclusion: {in: Search::ENGINES}

  def attributes
    {"engine" => nil,
     "search" => nil,
     "results" => []}
  end

  private

  def perform_search
    @results = []
  end
end
