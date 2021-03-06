require "simplecov"
require "paperclip/matchers"
require "rspec/active_model/mocks"

module SpecHelpers
  def category1
    Category.find_or_create_by!(name: "festivals")
  end

  def user1
    User.create(
      first_name: "Dave",
      last_name: "Whit",
      email: "mustachefodays@example.com",
      password: "password",
      role: 0,
      fullname: "Dave Whit"
    )
  end

  def user2
    User.create(
      first_name: "Whitney",
      last_name: "Whit",
      email: "whit@example.com",
      password: "password",
      role: 0,
      fullname: "Whitney Whit"
    )
  end

  def suspended_user
    User.create(
      first_name: "Monica",
      last_name: "Whooo",
      email: "monice@example.com",
      password: "password",
      role: 0,
      fullname: "Monica Whooo",
      status: "suspended")
  end

  def category2
    Category.find_or_create_by!(name: "sports")
  end

  def venue1
    Venue.find_or_create_by!(name: "Neat Ampitheatre", city: "Des Moines", state: "Iowa")
  end

  def venue2
    Venue.find_or_create_by!(name: "Stadium", city: "Denver", state: "Colorado")
  end

  def event1
    category1.events.find_or_create_by!(
      name: "Sun Festival",
      venue_id: venue1.id,
      time: "March 02, 2017 16:00",
      status: "active")
  end

  def event2
    category1.events.find_or_create_by!(
      name: "Moon Festival",
      venue_id: venue1.id,
      time: "March 02, 2015 16:00",
      status: "active")
  end

  def event3
    category1.events.create!(
      name: "Old Festival",
      venue_id: venue1.id,
      time: "March 02, 2015 16:00",
      status: "active")
  end

  def make_listings_and_tickets
    user_1 = user1
    user_2 = user2

    listing_1 = event1.listings.new(user_id: user_1.id)
    listing_1.tickets << Ticket.new(price: 800, seat: "10", row: "5")
    listing_1.tickets << Ticket.new(price: 800, seat: "11", row: "5")
    listing_1.save

    listing_2 = event1.listings.new(user_id: user_2.id)
    listing_2.tickets << Ticket.new(price: 1000, seat: "1", row: "1")
    listing_2.save

    listing_3 = event1.listings.new(user_id: user_1.id)
    listing_3.tickets << Ticket.new(price: 2000, seat: "90", row: "5", status: "purchased")
    listing_3.tickets << Ticket.new(price: 2000, seat: "91", row: "5")
    listing_3.save

    listing_4 = event1.listings.new(user_id: user_1.id)
    listing_4.tickets << Ticket.new(price: 1000, seat: "7", row: "1")
    listing_4.save
  end

  def make_listings
    user_1 = user1
    user_2 = user2
    
    listing_1 = event1.listings.new(user_id: user_1.id)
    listing_1.tickets << Ticket.new(price: 800, seat: "10", row: "5")
    listing_1.tickets << Ticket.new(price: 800, seat: "11", row: "5")
    listing_1.save

    listing_3 = event1.listings.new(user_id: user_1.id)
    listing_3.tickets << Ticket.new(price: 2000, seat: "90", row: "5", status: "purchased")
    listing_3.tickets << Ticket.new(price: 2000, seat: "91", row: "5")
    listing_3.save
  end

  def create_order(user)
    user.orders.create(street: "1600 pennslyvania",
                       city: "washington",
                       state: "District of Columbia",
                       zip: "46250",
                       fullname: "jonathon adams",
                       first_name: "jonathon",
                       last_name: "adams",
                       email: "spam@foundingfathers.biz")
  end

  def make_listings_and_tickets_dashboard
    user_1 = user1
    user_2 = user2

    listing_1 = event1.listings.new(user_id: user_1.id)
    listing_1.tickets << Ticket.new(price: 800, seat: "10", row: "5")
    listing_1.tickets << Ticket.new(price: 800, seat: "11", row: "5")
    listing_1.save

    listing_2 = event1.listings.new(user_id: user_2.id)
    listing_2.tickets << Ticket.new(price: 1000, seat: "90", row: "50")
    listing_2.save

    listing_3 = event1.listings.new(user_id: user_1.id)
    listing_3.tickets << Ticket.new(price: 2000, seat: "30", row: "5", status: "purchased")
    listing_3.tickets << Ticket.new(price: 2000, seat: "31", row: "5")
    listing_3.save

    listing_4 = event2.listings.new(user_id: user_1.id)
    listing_4.tickets << Ticket.new(price: 1000, seat: "1", row: "1")
    listing_4.save
  end

  def make_listing
    user_1 = user1
    listing = event1.listings.new(user_id: user_1.id)
    listing.tickets << Ticket.new(price: 800, seat: "10", row: "5")
    listing.tickets << Ticket.new(price: 800, seat: "11", row: "5")
    listing.save
  end

  def make_events
    {
      event1: category1.events.create!(
        name: "Sun Festival",
        venue_id: venue1.id,
        time: "March 02, 2017 16:00",
        status: "active"),
      event2: category1.events.create!(
        name: "EDM Spectacular",
        venue_id: venue1.id,
        time: "November 20, 2020 18:00",
        status: "active"),
      event3: category2.events.create!(
        name: "Basketball",
        venue_id: venue2.id,
        time: "July 10, 2016 19:00",
        status: "active")
    }
  end

  def tag1
    Tag.find_or_create_by(name: "family")
  end

  def tag2
    Tag.find_or_create_by(name: "basketball")
  end

  def tag3
    Tag.find_or_create_by(name: "death metal")
  end

  def create_and_stub_admin
    admin = User.create(fullname: "John Adams",
                        email:      "admin@example.com",
                        password:   "password",
                        role: 1)
    ApplicationController.any_instance.stub(:current_user) { admin }
    admin
  end
end

SimpleCov.start("rails")

RSpec.configure do |config|
  config.include Paperclip::Shoulda::Matchers
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
