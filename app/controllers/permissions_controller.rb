class PermissionsController < ApplicationController
  before_action :set_permission, only: %i[ show edit update destroy ]

  # GET /permissions or /permissions.json
  def index
    @permissions = policy_scope(Permission)
  end

  # GET /permissions/1 or /permissions/1.json
  def show
    authorize @permission
  end

  # GET /permissions/new
  def new
    @permission = Permission.new
    authorize @permission
  end

  # GET /permissions/1/edit
  def edit
    authorize @permission
  end

  # POST /permissions or /permissions.json
  def create
    @permission = Permission.new(permission_params)
    authorize @permission

    respond_to do |format|
      if @permission.save
        format.html { redirect_to @permission, notice: t("permissions.create.success") }
        format.json { render :show, status: :created, location: @permission }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permissions/1 or /permissions/1.json
  def update
    authorize @permission

    respond_to do |format|
      if @permission.update(permission_params)
        format.html { redirect_to @permission, notice: t("permissions.update.success"), status: :see_other }
        format.json { render :show, status: :ok, location: @permission }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1 or /permissions/1.json
  def destroy
    authorize @permission

    @permission.destroy!

    respond_to do |format|
      format.html { redirect_to permissions_path, notice: t("permissions.destroy.success"), status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permission
      @permission = Permission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def permission_params
      params.require(:permission).permit(:name)
    end
end
