class OrderDetail < ApplicationRecord
  
  has_many :items, dependent: :destory
  belongs_to :order
  
  enum order_status: {着手不可:0, 製作待ち:1, 製作中:2, 製作完了:3}
  
end
