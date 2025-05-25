class PagesController < ApplicationController
  def home
    @featured_products = Product.featured.limit(6)
    @latest_products = Product.active.order(created_at: :desc).limit(8)
  end

  def about
  end
end 