class ShippingAddress < ApplicationRecord

  belongs_to :customer

  def shipping_postcode_and_address_and_name
    "〒#{self.shipping_postcode}  #{self.shipping_address}  #{self.shipping_name}"
  end

end
