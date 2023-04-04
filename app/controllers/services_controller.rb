class ServicesController < ApplicationController
  before_action :authenticate_user
  before_action :set_category
  before_action :set_service, only: %i[ show edit update destroy ]

  def index
    @services = @category.services
  end

  def show
  end

  def new
    @service = @category.services.build
  end

  def edit
  end

  def create
    @service = @category.services.build(service_params)

    if @service.save
      redirect_to category_path(@category), notice: "Service created!"
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    if @service.update(service_params)
      redirect_to category_path(@category), notice: "Service updated!" 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
    redirect_to category_path(@category), notice: "Service deleted!"
  end

  private
    def set_service
      @service = @category.services.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:name, :details, :price, :image, :service_type)
    end

    def set_category
      @category = Category.find(params[:category_id])
    end
end
