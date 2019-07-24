class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :destroy, :update]

  def new
    @item = Item.find(params[:item_id])
    @review = Review.new
  end

  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.new(review_params)
    if @review.save
      redirect_to item_path(@item)
    else
      generate_flash(@review)
      render :new
    end
  end

  def edit
  end

  def update
    @review.update(review_params)
    redirect_to item_path(@review.item)
  end

  def destroy
    @review.destroy
    redirect_to(item_path(@review.item))
  end

  private

  def review_params
    params.require(:review).permit(:title, :description, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
