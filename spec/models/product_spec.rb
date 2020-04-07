require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @new_category = Category.new({name:"Food"})
      
    end
    it "validates correctly" do
      @new_product = Product.new({name:"Bread", description:"Loaf of bread", category:@new_category, image:"https://i.imgur.com/hk766co.jpg" ,quantity:1, price:100})
      @new_product.valid?
      expect(!@new_product.errors.full_messages)
    end
    it "Has a name" do
      @new_product = Product.new({name:nil, description:"Loaf of bread", category:@new_category, image:"https://i.imgur.com/hk766co.jpg" ,quantity:1, price:100})
      @new_product.valid?
      expect(@new_product.errors.full_messages).to include("Name can't be blank")
    end
    it "Has a price" do
      @new_product = Product.new({name:"Bread", description:"Loaf of bread", category:@new_category, image:"https://i.imgur.com/hk766co.jpg" ,quantity:1, price:nil})
      @new_product.valid?
      expect(@new_product.errors.full_messages).to include("Price can't be blank")
    end
    it "Has a quantity" do
      @new_product = Product.new({name:"Bread", description:"Loaf of bread", category:@new_category, image:"https://i.imgur.com/hk766co.jpg" ,quantity:nil, price:100})
      @new_product.valid?
      expect(@new_product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "Has a category" do
      @new_product = Product.new({name:"Bread", description:"Loaf of bread", category:nil, image:"https://i.imgur.com/hk766co.jpg" ,quantity:1, price:100})
      @new_product.valid?
      expect(@new_product.errors.full_messages).to include("Category can't be blank")
    end

  end
end