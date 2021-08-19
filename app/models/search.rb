# This is a recordless model (i.e. does not exist in a database)

class Search
  include ActiveModel::Model

  attr_accessor :engine, :search

  validates :engine, :search, presence: true
end
