class VesselsController < ApplicationController
  before_action :set_vessel, only: %i[ show edit update destroy ]

  # GET /vessels or /vessels.json
  def index
    @vessels = if params[:query].present?
      Vessel.includes(:shipping_line).where("name ILIKE ?", "%#{params[:query]}%").page(params[:page]).per(params[:per_page] || 10)
    else
      Vessel.includes(:shipping_line).all.page(params[:page]).per(params[:per_page] || 10)
    end
  end

  # GET /vessels/1 or /vessels/1.json
  def show
  end

  # GET /vessels/new
  def new
    @vessel = Vessel.new
  end

  # GET /vessels/1/edit
  def edit
  end

  # POST /vessels or /vessels.json
  def create
    @vessel = Vessel.new(vessel_params)

    respond_to do |format|
      if @vessel.save
        format.html { redirect_to vessels_path, notice: I18n.t("vessels.create.success") }
        format.turbo_stream
        format.json { render :show, status: :created, location: @vessel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vessel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vessels/1 or /vessels/1.json
  def update
    respond_to do |format|
      if @vessel.update(vessel_params)
        format.html { redirect_to vessels_path, notice: I18n.t("vessels.update.success") }
        format.turbo_stream
        format.json { render :show, status: :ok, location: @vessel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vessel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vessels/1 or /vessels/1.json
  def destroy
    @vessel.destroy!

    respond_to do |format|
      format.html { redirect_to vessels_path, notice: I18n.t("vessels.destroy.success") }
      format.turbo_stream
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vessel
      @vessel = Vessel.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def vessel_params
      params.expect(vessel: [ :name, :shipping_line_id ])
    end
end
