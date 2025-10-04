require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  def new_product(title: "Product title", description: "Product description", price: 1, filename: "lorem.jpg", content_type: "image/jpeg")
    Product.new(title:, description:, price:).tap do |product|
      product.image.attach(
        io: File.open("test/fixtures/files/#{filename}"),
        filename:,
        content_type:
      )
    end
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image].any?
  end

  test "product price must be positive" do
    product = new_product(price: -1)
    assert product.invalid?
    assert_includes product.errors[:price], "must be greater than or equal to 0.01"

    product.price = 0
    assert product.invalid?
    assert_includes product.errors[:price], "must be greater than or equal to 0.01"

    product.price = 0.01
    assert product.valid?
  end

  test "image content_type is valid" do
    product = new_product(filename: "lorem.jpg", content_type: "image/jpeg")
    assert product.valid?, "image/jpeg must be valid"

    product = new_product(filename: "favicon.svg", content_type: "image/svg+xml")
    assert product.invalid?
  end

  test "product is not valid without a unique title" do
    product = new_product(title: products(:one).title)
    assert product.invalid?
    assert_equal [ I18n.translate("errors.messages.taken") ], product.errors[:title]
  end
end
