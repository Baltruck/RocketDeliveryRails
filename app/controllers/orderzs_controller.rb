class OrderzsController < ApplicationController
  before_action :set_orderz, only: %i[ show edit update destroy ]
  before_action :require_employee

  # GET /orderzs or /orderzs.json
  def index
    @orderzs = Orderz.all
  end

  # GET /orderzs/1 or /orderzs/1.json
  def show
  end

  # GET /orderzs/new
  def new
    @orderz = Orderz.new
  end

  # GET /orderzs/1/edit
  def edit
  end

  # POST /orderzs or /orderzs.json
  def create
    @orderz = Orderz.new(orderz_params)
    puts params.inspect

    respond_to do |format|
      if @orderz.save
        format.html { redirect_to orderz_url(@orderz), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @orderz }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @orderz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orderzs/1 or /orderzs/1.json
  def update
    respond_to do |format|
      if @orderz.update(orderz_params)
        format.html { redirect_to orderz_url(@orderz), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @orderz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @orderz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orderzs/1 or /orderzs/1.json
  def destroy
    @orderz.destroy

    respond_to do |format|
      format.html { redirect_to orderzs_url, notice: "Order was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orderz
      @orderz = Orderz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def orderz_params
      params.require(:orderz).permit(:restaurant_rating, :restaurant_id, :customer_id, :order_status_id)
    end

    # Only allow acces to employees.
    def require_employee
      unless current_user && Employee.exists?(user_id: current_user.id)
        flash[:alert] = "You must be an employee to access this page."
        redirect_to root_path
      end
    end
end
