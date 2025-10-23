require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Beer Store Order Confirmation", mail.subject
    assert_equal [ "johndoe@example.com" ], mail.to
    assert_equal [ "alexanderluna@example.com" ], mail.from
    assert_match (/1 x Lager Beer/), mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Beer Store Order Shipped", mail.subject
    assert_equal [ "johndoe@example.com" ], mail.to
    assert_equal [ "alexanderluna@example.com" ], mail.from
    # <td class="text-right"><%= line_item.quantity %></td>
    # <td>&times;</td>
    # <td class="pr-2"><%= line_item.product.title %></td>
    assert_match %r{
      <td[^>]*>1<\/td>\s*
      <td>&times;<\/td>\s*
      <td[^>]*>\s*Lager\sBeer\s*<\/td>
    }x, mail.body.encoded
  end
end
