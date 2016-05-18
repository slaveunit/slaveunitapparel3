 class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!,:except => [:show, :index]

# So admin abilities are applied to only these.  
# So public can view product without signing in.
  load_and_authorize_resource :only => [:new, :update, :create, :destroy]

  # ANGULAR
  #respond_to :json, :html

  # GET /products
  # GET /products.json
  def index
  # FOR SEARCH FORM TO USE LIKE IN DEVELOPMENT
      if Rails.env.development?
        if params[:q]
          search_term = params[:q]
          @products = Product.where("name LIKE ?", "%#{search_term}%")
          
          # ANGULAR
          #respond_with @products
          
        else
          @products = Product.all
# SHOPPING CART
    @order_item = current_order.order_items.new
# SHOPPING CART      
        end
      end
  # FOR SEARCH FORM TO USE ILIKE IN PRODUCTION
      if Rails.env.production?
        if params[:q]
          search_term = params[:q]
          @products = Product.where("name ILIKE ?", "%#{search_term}%")
        else
          @products = Product.all
# SHOPPING CART
    @order_item = current_order.order_items.new
# SHOPPING CART          
        end
      end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # GET /products/1
  # GET /products/1.json
  # PAGINATE
  def show
    @comments = @product.comments.order("created_at DESC").paginate(page: params[:page], per_page: 3)
    @product = Product.find(params[:id])
    @order_item = current_order.order_items.new
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
  # PAPERCLIP, added for: "params[:photo]"
  def create
    @product = Product.new(product_params, params[:photo] )
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
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
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private


  # Never trust parameters from the scary internet, only allow the white list through.
# PAPERCLIP added :photo
# PRICE added :decimal
  def product_params
    params.require(:product).permit :name, :description, :image_url, :colour, :photo, :photo_file_name, :photo_file_size, :photo_content_type, :photo_updated_at, :price, :decimal, :precision, :scale, :size
  end


end