# This is a recordless model (i.e. does not exist in a database)

class Search
  ENGINES = ["bing", "both", "google"]

  include ActiveModel::Model
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations::Callbacks

  after_validation :perform_search unless Rails.env.test?

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
    if @engine == "google" || @engine == "both"
      GoogleSearchService.new(@search).schema.each { |result| @results.push(Result.new(result)); }
    end
    if @engine == "bing" || @engine == "both"
      BingSearchService.new(@search).schema.each { |result| @results.push(Result.new(result)); }
    end
    @results = @results.select { |result| result.valid? }.sort_by do |element|
      Digest::MD5.hexdigest(Marshal.dump(element))
    end
  end
end
