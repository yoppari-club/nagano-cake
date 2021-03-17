class CartItem < ApplicationRecord
  validates :amount, numericality: { greater_than: 0 }

  belongs_to :customer
  belongs_to :item

end
