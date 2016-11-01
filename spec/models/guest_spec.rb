require 'rails_helper'

RSpec.describe(Guest, type: :model) do
  let(:guest) do
    Guest.create!(full_name: 'Bubbles')
  end

  describe('#valid?') do
    it('requires :full_name to be present') do
      new_guest = Guest.new
      expect(new_guest).not_to be_valid
      expect(new_guest.errors[:full_name]).to include("can't be blank")
    end
  end

  describe('#tickets') do
    it('returns the tickets belonging to the guest') do
      ticket = Ticket.create!(
        number: 1,
        lottery: Lottery.create!(event_date: Date.today),
        seller: Seller.create!(full_name: 'Gonzo'),
        guest: guest,
      )
      expect(guest.tickets).to eq([ticket])
    end
  end
end
