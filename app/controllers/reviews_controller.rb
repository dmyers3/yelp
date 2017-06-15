class ReviewsController < ApplicationController
  before_action :redirect_logged_out, only: [:create, :new]
  
  def new
    @review = Review.new
  end
  
  def create
    
    @review = Review.new(review_params)
    @review.user = current_user
    # params[:business_id] comes from business show page, params[:review][:business_id]
    # comes from new_review_path
    @business = Business.find(params[:business_id] || params[:review][:business_id])
    @review.business = @business
    
    if @review.save
      flash[:success] = "Review successfully created"
      redirect_to business_path(@business)
    else
      params[:business_id] ? render(template: "businesses/show") : render(:new)
    end
  end
  
  private
  
  def review_params
    params.require("review").permit("rating", "description")
  end
end