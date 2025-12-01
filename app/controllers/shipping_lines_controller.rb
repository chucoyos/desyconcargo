class ShippingLinesController < ApplicationController
  def index
    @shipping_lines = ShippingLine.all
  end

  def show
    @shipping_line = ShippingLine.find(params[:id])
  end

  def new
    @shipping_line = ShippingLine.new
  end

  def create
    @shipping_line = ShippingLine.new(shipping_line_params)
    if @shipping_line.save
      redirect_to shipping_lines_path, notice: "Shipping line created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @shipping_line = ShippingLine.find(params[:id])
  end

  def update
    @shipping_line = ShippingLine.find(params[:id])
    if @shipping_line.update(shipping_line_params)
      redirect_to shipping_line_path(@shipping_line), notice: "Shipping line updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shipping_line = ShippingLine.find(params[:id])
    @shipping_line.destroy
    redirect_to shipping_lines_path, notice: "Shipping line deleted successfully."
  end

  private

  def shipping_line_params
    params.require(:shipping_line).permit(:name)
  end
end
