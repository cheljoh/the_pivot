# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :integer          default(0)
#  fullname        :string
#  status          :string           default("active")
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should validate_presence_of :fullname}
  it { should validate_presence_of :email}
  it { should validate_presence_of :password_digest}
  it { should validate_presence_of :status }
  it { should validate_inclusion_of(:status).in_array(%w(active suspended)) }

  it { should have_many :order_products }
  it { should have_many :orders }
end
