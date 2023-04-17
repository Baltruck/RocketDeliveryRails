class CustomerzsController < ApplicationController
  before_action :set_customerz, only: %i[ show edit update destroy ]
  before_action :require_employee

  # GET /customerzs or /customerzs.json
  def index
    @customerzs = Customerz.all
  end

  # GET /customerzs/1 or /customerzs/1.json
  def show
  end

  # GET /customerzs/new
  def new
    @customerz = Customerz.new
  end

  # GET /customerzs/1/edit
  def edit
  end

  # POST /customerzs or /customerzs.json
  def create
    @customerz = Customerz.new(customerz_params)

    respond_to do |format|
      if @customerz.save
        format.html { redirect_to customerz_url(@customerz), notice: "Customer was successfully created." }
        format.json { render :show, status: :created, location: @customerz }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customerz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customerzs/1 or /customerzs/1.json
  def update
    respond_to do |format|
      if @customerz.update(customerz_params)
        format.html { redirect_to customerz_url(@customerz), notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customerz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customerz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customerzs/1 or /customerzs/1.json
  def destroy
    @customerz.destroy

    respond_to do |format|
      format.html { redirect_to customerzs_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customerz
      @customerz = Customerz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customerz_params
      params.require(:customerz).permit(:phone, :email, :active, :user_id, :address_id)
    end

    # Only allow acces to employees.
    def require_employee
      unless current_user && Employee.exists?(user_id: current_user.id)
        flash[:alert] = "You must be an employee to access this page."
        redirect_to root_path
      end
  end
end
