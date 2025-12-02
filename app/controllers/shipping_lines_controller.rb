class ShippingLinesController < ApplicationController
  def index
    @shipping_lines = if params[:query].present?
                        ShippingLine.where("name ILIKE ?", "%#{params[:query]}%").page(params[:page]).per(params[:per_page] || 10)
    else
                        ShippingLine.all.page(params[:page]).per(params[:per_page] || 10)
    end
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
      respond_to do |format|
        format.html { redirect_to shipping_lines_path, notice: I18n.t("shipping_lines.create.success") }
        format.turbo_stream
      end
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
      respond_to do |format|
        format.html { redirect_to shipping_lines_path, notice: I18n.t("shipping_lines.update.success") }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shipping_line = ShippingLine.find(params[:id])

    if @shipping_line.vessels.exists?
      respond_to do |format|
        format.html do
          redirect_to shipping_lines_path, alert: I18n.t("shipping_lines.destroy.error_with_vessels", name: @shipping_line.name)
        end
        format.turbo_stream do
          flash.now[:alert] = I18n.t("shipping_lines.destroy.error_with_vessels", name: @shipping_line.name)
          render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
        end
      end
    else
      @shipping_line.destroy
      respond_to do |format|
        format.html { redirect_to shipping_lines_path, notice: I18n.t("shipping_lines.destroy.success") }
        format.turbo_stream
      end
    end
  end

  private

  def shipping_line_params
    params.require(:shipping_line).permit(:name)
  end
end
