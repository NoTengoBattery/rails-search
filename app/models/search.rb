# This is a recordless model (i.e. does not exist in a database)

class Search
  ENGINES = ["bing", "both", "google"]

  include ActiveModel::Model

  attr_accessor :engine, :search

  validates :engine, :search, presence: true
  validates :engine, inclusion: {in: Search::ENGINES}
end
