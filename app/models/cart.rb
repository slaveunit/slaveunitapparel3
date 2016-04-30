class Cart < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  belongs_to :payments

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :product_present
  validate :order_present

  
end
