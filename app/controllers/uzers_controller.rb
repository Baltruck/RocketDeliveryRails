class UzersController < ApplicationController
  before_action :set_uzer, only: %i[ show edit update destroy ]
  before_action :require_employee

  # GET /uzers or /uzers.json
  def index
    @uzers = Uzer.all
  end

  # GET /uzers/1 or /uzers/1.json
  def show
  end

  # GET /uzers/new
  def new
    @uzer = Uzer.new
  end

  # GET /uzers/1/edit
  def edit
  end

  # POST /uzers or /uzers.json
  def create
    @uzer = Uzer.new(uzer_params)

    respond_to do |format|
      if @uzer.save
        format.html { redirect_to uzer_url(@uzer), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @uzer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @uzer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uzers/1 or /uzers/1.json
def update
  if params[:uzer][:password].blank?
    params[:uzer].delete(:password)
  end

  respond_to do |format|
    if @uzer.update(uzer_params)
      format.html { redirect_to uzer_url(@uzer), notice: "User was successfully updated." }
      format.json { render :show, status: :ok, location: @uzer }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @uzer.errors, status: :unprocessable_entity }
    end
  end
end


  # DELETE /uzers/1 or /uzers/1.json
  def destroy
    @uzer.destroy

    respond_to do |format|
      format.html { redirect_to uzers_url, notice: "User was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uzer
      @uzer = Uzer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def uzer_params
      params.require(:uzer).permit(:email, :name, :password)
    end
    
    # Only allow acces to employees.
    def require_employee
      unless current_user && Employee.exists?(user_id: current_user.id)
        flash[:alert] = "You must be an employee to access this page."
        redirect_to root_path
      end
    end
end
