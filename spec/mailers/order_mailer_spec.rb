require 'spec_helper'

RSpec.describe OrderMailer do
  describe 'email' do
    before :each do
      pending
      @user = User.create(fullname: "Lucas Jones", password: "password", email: "lucas@email.com")

      Category.create(name: "coffee")

      Product.create(name: "test", price: 23, description: "test", category_id: Category.last.id)

      @order = Order.create(first_name: 'Lucas', last_name: "Jones", street: "123 St.", city: "Denver", state: "CO", zip: "80209", user_id: User.last.id, email: 'lucas@email.com', fullname: "Lucas Jones", order_total: "40")

      @order.order_products.create(product_id: Product.last.id, order_id: Order.last.id, quantity: 1)
    end

    let(:mail) { OrderMailer.order_email(@order) }

    xit 'renders the subject' do
      expect(mail.subject).to eql('🎉Alright, Alright, Alright. Your joe is on the way!🎉')
    end

    xit 'renders the receiver email' do
      expect(mail.to).to eql([@user.email])
    end

    xit 'renders the sender email' do
      expect(mail.from).to eql(['littleowlturing@gmail.com'])
    end

    xit 'assigns @order.fullname' do
      expect(mail.body.encoded).to match(@user.fullname)
    end
  end
end
