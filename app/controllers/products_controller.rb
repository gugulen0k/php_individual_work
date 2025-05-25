class ProductsController < ApplicationController
  def index
    @products = Product.order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.search(params[:query]).page(params[:page]).per(12)
    render :index
  end
end 