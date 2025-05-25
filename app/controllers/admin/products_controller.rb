module Admin
  class ProductsController < Admin::BaseController
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    def index
      @products = Product.all.order(created_at: :desc).page(params[:page])
    end

    def show
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      respond_to do |format|
        if @product.save
          format.html { redirect_to admin_products_path, notice: 'Product was successfully created.' }
          format.turbo_stream { 
            flash.now[:notice] = 'Product was successfully created.'
            redirect_to admin_products_path
          }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.turbo_stream { 
            flash.now[:alert] = 'Error creating product.'
            render :new, status: :unprocessable_entity 
          }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to admin_products_path, notice: 'Product was successfully updated.' }
          format.turbo_stream { 
            flash.now[:notice] = 'Product was successfully updated.'
            redirect_to admin_products_path
          }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.turbo_stream { 
            flash.now[:alert] = 'Error updating product.'
            render :edit, status: :unprocessable_entity 
          }
        end
      end
    end

    def destroy
      @product.destroy
      respond_to do |format|
        format.html { redirect_to admin_products_path, notice: 'Product was successfully deleted.' }
        format.turbo_stream { 
          flash.now[:notice] = 'Product was successfully deleted.'
          redirect_to admin_products_path
        }
      end
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image_url, :featured, :active)
    end
  end
end 