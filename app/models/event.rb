class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :venue
  has_many :listings

  # has_many :order_products
  # has_many :orders, through: :order_products

  # validates :name, presence: true, uniqueness: true
  # validates :price, presence: true
  # validates :description, presence: true
  # validates :category_id, presence: true

  has_attached_file :image,
      styles: { index: '275x175>', show: '550x350<', small: '137.5x87.5>' },
      default_url: "logo.ico"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  scope :active_products, -> { where(inactive: false) }

  def display_price
    "$#{price.to_i / 100}"
  end

  def format_date
    time.strftime("%a,%e %b")
  end

  def format_time
    time.strftime("%I:%M%P")
  end

  def self.active_index
    where(inactive: false).order(:name)
  end

  def self.inactive_index
    where(inactive: true).order(:name)
  end

  def inactive?
    inactive
  end

  def self.category_distribution
    group(:category).count.map { |k, v| [k.name, v] }
  end
end
