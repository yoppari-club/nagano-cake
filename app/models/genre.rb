class Genre < ApplicationRecord
  has_many :items, dependet: :destroy
end
