class Category < ActiveRecord::Base
  has_many :events

  validates :name, presence: true
  validates :name, uniqueness: true

  def active_products
    products.active_products
  end
end
