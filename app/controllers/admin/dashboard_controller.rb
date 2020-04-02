class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']

  def show
    @product_count = Product.count().to_s
    @category_count = Category.count().to_s
  end
end
