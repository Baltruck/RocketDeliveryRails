class OrderStatusezsController < ApplicationController
  before_action :set_order_statusez, only: [:show, :edit, :update, :destroy]
  before_action :require_employee

  # GET /order_statusezs
  # GET /order_statusezs.json
  def index
    @order_statusezs = OrderStatusezs.all
  end

  # GET /order_statusezs/1
  # GET /order_statusezs/1.json
  def show
  end

  # GET /order_statusezs/new
  def new
    @order_statusez = OrderStatusezs.new
  end

  # GET /order_statusezs/1/edit
  def edit
  end

  # POST /order_statusezs
  # POST /order_statusezs.json
  def create
    @order_statusez = OrderStatusezs.new(order_statusez_params)

    respond_to do |format|
      if @order_statusez.save
        format.html { redirect_to @order_statusez, notice: 'Order statusez was successfully created.' }
        format.json { render :show, status: :created, location: @order_statusez }
      else
        format.html { render :new }
        format.json { render json: @order_statusez.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_statusezs/1
  # PATCH/PUT /order_statusezs/1.json
  def update
    respond_to do |format|
      if @order_statusez.update(order_statusez_params)
        format.html { redirect_to @order_statusez, notice: 'Order statusez was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_statusez }
      else
        format.html { render :edit }
        format.json { render json: @order_statusez.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_statusezs/1
  # DELETE /order_statusezs/1.json
  def destroy
    @order_statusez.destroy
    respond_to do |format|
      format.html { redirect_to order_statusezs_url, notice: 'Order statusez was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_statusez
      @order_statusez = OrderStatusezs.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_statusez_params
      params.require(:order_statusez).permit(:name)
    end

    # Only allow acces to employees.
    def require_employee
      unless current_user && Employee.exists?(user_id: current_user.id)
        flash[:alert] = "You must be an employee to access this page."
        redirect_to root_path
      end
    end
end
