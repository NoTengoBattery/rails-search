class SearchesController < ApplicationController
  def search
    @search = Search.new(search_params)

    if @search.valid?
      render json: @search
    else
      render json: {error: :invalid}, status: :unprocessable_entity
    end
  end

  private

  def search_params
    params.permit(:engine, :search)
  end
end
