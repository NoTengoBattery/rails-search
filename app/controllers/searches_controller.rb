class SearchesController < ApplicationController
  def search
  end

  private

  def search_params
    params.permit(:engine, :search)
  end
end
