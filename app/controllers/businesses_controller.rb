class BusinessesController < ApplicationController
  before_action :redirect_logged_out, except: [:index, :show]
  
  def index
    @businesses = Business.all
  end
  
  def show
    @business = Business.find(params[:id])
    @review = Review.new if logged_in?
  end
  
  def new
    @business = Business.new
  end
  
  def create
    @business = Business.new(business_params)
    
    if @business.save
      flash[:success] = "Business successfully created."
      redirect_to @business
    else
      render 'new'
    end
  end
  
  
  private
  
  def business_params
    params.require('business').permit('name', 'street_address_1', 'street_address_2',
    'city', 'state', 'zip', 'phone_number')
  end
end