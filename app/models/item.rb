class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  has_many :orders, through: :order_details

  attachment :image

  validates :name, presence: true
  validates :description, presence: true
  validates :genre, presence: true
  validates :price_excluding_tax, presence: true, numericality: { only_integer: true, greater_than: 0}
  
  def self.looks(word_for_search)
    @item = Item.where(genre: word_for_search)
  end
end
