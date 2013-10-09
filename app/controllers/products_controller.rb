class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    search_params = params.fetch(:search, {}).permit!
    @search_result = Product.search(search_params)
    @products = @search_result.page(params[:page])
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def import_csv
    @csv_upload = CsvUpload.new
  end

  def review_csv
    @csv_upload = CsvUpload.import(csv_params)

    respond_to do |format|
      if @csv_upload.errors.size == 0 && @csv_upload.valid?
        format.html # review_csv.html.erb
      else
        format.html { render action: 'import_csv' }
      end
    end
  end

  def bulk_insert
    @products = Product.bulk_insert(products_params)

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Products was successfully created.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:kind, :height, :is_emergency_exit, :is_openable)
    end

    def products_params
      params.require(:product).permit({kind: []}, {height: []}, {is_emergency_exit: []}, {is_openable: []})
    end

    def csv_params
      params.fetch(:csv_upload, {}).permit(:csv_file)
    end
end
