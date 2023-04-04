class CategoriesController < ApplicationController
  before_action :authenticate_user
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :clear_cart, only: :index
  before_action :clear_order, only: :show

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "Category created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to category_url(@category), notice: "Category updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: "Category deleted!"
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :image)
  end

  def clear_cart
    @cart.cart_items.destroy_all
    session.delete(:booking_id)
    session.delete(:order_id)
  end
  
  def clear_order
    if session[:order_id]
      Order.find(session[:order_id]).destroy
      session.delete(:order_id)
      session.delete(:booking_id)
    end
  end
end
