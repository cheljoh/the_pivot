class Ticket < ActiveRecord::Base
  belongs_to :listing
  validates :row, presence: true
  validates :seat, presence: true
  validates :price, presence: true

  def format_price
    "$#{price.to_i / 100}"
  end

  def get_event
    listing = Listing.find(listing_id)
    Event.find(listing.event_id)
  end
end
