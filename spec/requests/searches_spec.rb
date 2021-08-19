require "rails_helper"

RSpec.describe "/search", type: :request do
  def valid_attr
    search = FactoryBot.build(:search)
    valid_object = {}
    valid_object[:engine] = search.engine
    valid_object[:search] = search.search
    valid_object
  end

  let(:valid_attributes) { valid_attr }
  let(:invalid_attributes) { {engine: "", search: ""} }

  describe "GET /search" do
    it "renders a successful response with valid params" do
      search = Search.new(valid_attr)
      get search_url(search)
      expect(response).to be_successful
    end

    it "renders an unprocessable entity response with invalid params" do
      search = Search.new(invalid_attributes)
      get search_url(search)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
