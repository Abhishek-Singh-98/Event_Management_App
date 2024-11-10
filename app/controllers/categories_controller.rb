class CategoriesController < ApplicationController

  def create
    category = Category.new(name: params[:name])
    if category.save
      render json: category
    else
      render json: category.errors.messages, status: 422
    end
  end

  def filter_by_category
    @category = Category.find(params[:category_id])
    @events = @category.events
    render json: @events, each_serializer: EventSerializer
  end
end
