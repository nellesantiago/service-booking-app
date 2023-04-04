class TimeSlotsController < ApplicationController
  before_action :authenticate_user
  before_action :set_category
  before_action :set_time_slot, only: %i[ show edit update destroy ]

  def index
    @time_slots = @category.time_slots.order(:time)
  end

  def show
  end

  def new
    @time_slot = @category.time_slots.build
  end

  def edit  
  end

  def create
    @time_slot = @category.time_slots.build(time_slot_params)

    if @time_slot.save
      redirect_to category_time_slots_path(@category), notice: "Time slot created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @time_slot.update(time_slot_params)
      redirect_to category_time_slots_path(@category), notice: "Time slot updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @time_slot.destroy
    redirect_to category_time_slots_path(@category), notice: "Time slot deleted!"
  end

  private
    def set_time_slot
      @time_slot = @category.time_slots.find(params[:id])
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    def time_slot_params
      params.require(:time_slot).permit(:time, :max_slot)
    end
end
