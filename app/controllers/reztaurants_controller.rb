class ReztaurantsController < ApplicationController
  before_action :set_reztaurant, only: %i[ show edit update destroy ]
  before_action :require_employee


  # GET /reztaurants or /reztaurants.json
  def index
    @reztaurants = Reztaurant.all
  end

  # GET /reztaurants/1 or /reztaurants/1.json
  def show
  end

  # GET /reztaurants/new
  def new
    @reztaurant = Reztaurant.new
  end

  # GET /reztaurants/1/edit
  def edit
  end

  # POST /reztaurants or /reztaurants.json
  def create
    @reztaurant = Reztaurant.new(reztaurant_params)

    respond_to do |format|
      if @reztaurant.save
        format.html { redirect_to reztaurant_url(@reztaurant), notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @reztaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reztaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reztaurants/1 or /reztaurants/1.json
  def update
    respond_to do |format|
      if @reztaurant.update(reztaurant_params)
        format.html { redirect_to reztaurant_url(@reztaurant), notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @reztaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reztaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reztaurants/1 or /reztaurants/1.json
  # def destroy
  #   @reztaurant.destroy

  #   respond_to do |format|
  #     format.html { redirect_to reztaurants_url, notice: "Reztaurant was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reztaurant
      @reztaurant = Reztaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reztaurant_params
      params.require(:reztaurant).permit(:phone, :email, :name, :active, :address_id, :price_range, :user_id)
    end

    # Only allow acces to employees.
    def require_employee
      unless current_user && Employee.exists?(user_id: current_user.id)
        flash[:alert] = "You must be an employee to access this page."
        redirect_to root_path
      end
  end
end
