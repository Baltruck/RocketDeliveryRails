class ProductzsController < ApplicationController
  before_action :set_productz, only: %i[ show edit update destroy ]
  before_action :require_employee

  # GET /productzs or /productzs.json
  def index
    @productzs = Productz.all
  end

  # GET /productzs/1 or /productzs/1.json
  def show
  end

  # GET /productzs/new
  def new
    @productz = Productz.new
  end

  # GET /productzs/1/edit
  def edit
  end

  # POST /productzs or /productzs.json
  def create
    @productz = Productz.new(productz_params)

    respond_to do |format|
      if @productz.save
        format.html { redirect_to productz_url(@productz), notice: "Productz was successfully created." }
        format.json { render :show, status: :created, location: @productz }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @productz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productzs/1 or /productzs/1.json
  def update
    respond_to do |format|
      if @productz.update(productz_params)
        format.html { redirect_to productz_url(@productz), notice: "Productz was successfully updated." }
        format.json { render :show, status: :ok, location: @productz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @productz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productzs/1 or /productzs/1.json
  def destroy
    @productz.destroy

    respond_to do |format|
      format.html { redirect_to productzs_url, notice: "Productz was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_productz
      @productz = Productz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def productz_params
      params.require(:productz).permit(:name, :description, :cost, :restaurant_id, :product_id)
    end

    # Only allow acces to employees.
    def require_employee
      unless current_user && Employee.exists?(user_id: current_user.id)
        flash[:alert] = "You must be an employee to access this page."
        redirect_to root_path
      end
    end
end

