require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	def setup
		@product = Product.new(title: "Some random book", description: "This is a great book!",
								image_url: "image.jpg", price: 25.55)
	end

  test "product attributes must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:image_url].any?
  	assert product.errors[:price].any?
  end

  test "product price must be positive" do
  	products(:ruby).price = -1
  	assert_not products(:ruby).valid?
  	assert_equal ["must be greater than or equal to 0.01"], products(:ruby).errors[:price]
  	@product.price = 0
  	assert_not @product.valid?
  	assert_equal ["must be greater than or equal to 0.01"], @product.errors[:price]
  	@product.price = 1
  	assert @product.valid?
  end

  test "product image_url should be in format" do
  	good = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
  	bad = %w{ fred.doc fred.gif/more fred.gif.more }
  	good.each do |format|
  		@product.image_url = format
  		assert @product.valid?, "#{format} should be valid"
  	end
  	bad.each do |nonformat|
  		@product.image_url = nonformat
  		assert_not @product.valid?, "#{nonformat} should be invalid"
  	end
  end
  test "product is not avalaible with a duplicated title" do
    product = Product.new( title: products(:ruby).title, description: "It is a great book",
                            image_url: "wayne.jpg", price: 10.95)
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end
end
