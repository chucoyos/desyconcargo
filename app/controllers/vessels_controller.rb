class VesselsController < ApplicationController
  before_action :set_vessel, only: %i[ show edit update destroy ]

  # GET /vessels or /vessels.json
  def index
    @vessels = policy_scope(Vessel).includes(:shipping_line)

    # Apply search filter
    if params[:query].present?
      @vessels = @vessels.where("name ILIKE ?", "%#{params[:query]}%")
    end

    # Apply shipping line filter
    if params[:shipping_line_id].present? && params[:shipping_line_id] != ""
      @vessels = @vessels.where(shipping_line_id: params[:shipping_line_id])
    end

    @vessels = @vessels.page(params[:page]).per(params[:per_page] || 10)
  end

  # GET /vessels/1 or /vessels/1.json
  def show
  end

  # GET /vessels/new
  def new
    @vessel = Vessel.new
    authorize Vessel
  end

  # GET /vessels/1/edit
  def edit
    authorize @vessel
  end

  # POST /vessels or /vessels.json
  def create
    authorize Vessel
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
    authorize @vessel
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
    authorize @vessel
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
