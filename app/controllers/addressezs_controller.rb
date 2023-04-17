class AddressezsController < ApplicationController
  before_action :set_addressez, only: %i[ show edit update destroy ]
  before_action :require_employee

  # GET /addressezs or /addressezs.json
  def index
    @addressezs = Addressez.all
  end

  # GET /addressezs/1 or /addressezs/1.json
  def show
  end

  # GET /addressezs/new
  def new
    @addressez = Addressez.new
  end

  # GET /addressezs/1/edit
  def edit
  end

  # POST /addressezs or /addressezs.json
  def create
    @addressez = Addressez.new(addressez_params)

    respond_to do |format|
      if @addressez.save
        format.html { redirect_to addressez_url(@addressez), notice: "Addresse was successfully created." }
        format.json { render :show, status: :created, location: @addressez }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @addressez.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addressezs/1 or /addressezs/1.json
  def update
    respond_to do |format|
      if @addressez.update(addressez_params)
        format.html { redirect_to addressez_url(@addressez), notice: "Addressez was successfully updated." }
        format.json { render :show, status: :ok, location: @addressez }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @addressez.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addressezs/1 or /addressezs/1.json
  def destroy
    @addressez.destroy

    respond_to do |format|
      format.html { redirect_to addressezs_url, notice: "Addressez was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_addressez
      @addressez = Addressez.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def addressez_params
      params.require(:addressez).permit(:street_address, :city, :postal_code)
    end

    # Only allow acces to employees.
    def require_employee
      unless current_user && Employee.exists?(user_id: current_user.id)
        flash[:alert] = "You must be an employee to access this page."
        redirect_to root_path
      end
    end
end
