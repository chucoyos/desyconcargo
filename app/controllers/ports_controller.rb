class PortsController < ApplicationController
  before_action :set_port, only: %i[ show edit update destroy ]

  # GET /ports or /ports.json
  def index
    @ports = if params[:query].present?
               Port.where("name ILIKE ? OR uncode ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").page(params[:page]).per(params[:per_page] || 10)
    else
               Port.all.page(params[:page]).per(params[:per_page] || 10)
    end
  end

  # GET /ports/1 or /ports/1.json
  def show
  end

  # GET /ports/new
  def new
    @port = Port.new
  end

  # GET /ports/1/edit
  def edit
  end

  # POST /ports or /ports.json
  def create
    @port = Port.new(port_params)

    respond_to do |format|
      if @port.save
        format.html { redirect_to ports_path, notice: I18n.t("ports.create.success") }
        format.turbo_stream
        format.json { render :show, status: :created, location: @port }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
        format.json { render json: @port.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ports/1 or /ports/1.json
  def update
    respond_to do |format|
      if @port.update(port_params)
        format.html { redirect_to ports_path, notice: I18n.t("ports.update.success") }
        format.turbo_stream
        format.json { render :show, status: :ok, location: @port }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
        format.json { render json: @port.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ports/1 or /ports/1.json
  def destroy
    @port.destroy!

    respond_to do |format|
      format.html { redirect_to ports_path, notice: I18n.t("ports.destroy.success") }
      format.turbo_stream
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_port
      @port = Port.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def port_params
      params.expect(port: [ :name, :country, :uncode ])
    end
end
