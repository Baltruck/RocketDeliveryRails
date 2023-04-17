class ProductOrderzsController < ApplicationController
  before_action :set_product_orderz, only: %i[ show edit update destroy ]
  before_action :require_employee

  # GET /product_orderzs or /product_orderzs.json
  def index
    @product_orderzs = ProductOrderz.all
  end

  # GET /product_orderzs/1 or /product_orderzs/1.json
  def show
  end

  # GET /product_orderzs/new
  def new
    @product_orderz = ProductOrderz.new
  end

  # GET /product_orderzs/1/edit
  def edit
  end

  # POST /product_orderzs or /product_orderzs.json
  def create
    @product_orderz = ProductOrderz.new(product_orderz_params)

    respond_to do |format|
      if @product_orderz.save
        format.html { redirect_to product_orderz_url(@product_orderz), notice: "Product order was successfully created." }
        format.json { render :show, status: :created, location: @product_orderz }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_orderz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_orderzs/1 or /product_orderzs/1.json
  def update
    respond_to do |format|
      if @product_orderz.update(product_orderz_params)
        format.html { redirect_to product_orderz_url(@product_orderz), notice: "Product orderz was successfully updated." }
        format.json { render :show, status: :ok, location: @product_orderz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_orderz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_orderzs/1 or /product_orderzs/1.json
  def destroy
    @product_orderz.destroy

    respond_to do |format|
      format.html { redirect_to product_orderzs_url, notice: "Product orderz was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_orderz
      @product_orderz = ProductOrderz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_orderz_params
      params.require(:product_orderz).permit(:product_quantity, :product_unit_cost)
    end

    # Only allow acces to employees.
    def require_employee
      unless current_user && Employee.exists?(user_id: current_user.id)
        flash[:alert] = "You must be an employee to access this page."
        redirect_to root_path
      end
    end
end
