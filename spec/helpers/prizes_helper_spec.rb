# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(PrizesHelper, type: :helper) do
  include I18nSpecHelper

  let(:lottery) do
    Lottery.create!(event_date: Time.zone.today)
  end

  let(:prize) do
    Prize.create!(
      lottery: lottery,
      draw_order: 1,
      amount: 250.00,
    )
  end

  context('#display_draw_position') do
    it('returns "275" when prize#nth_before_last is 275') do
      prize.nth_before_last = 275
      expect(display_draw_position(prize)).to eq('275')
    end

    it('returns "First announced" when prize#nth_before_last is nil') do
      prize.nth_before_last = nil

      with_locale(:en) do
        expect(display_draw_position(prize)).to eq('First announced')
      end

      with_locale(:fr) do
        expect(display_draw_position(prize)).to eq('Premier annoncé')
      end
    end

    it('returns "Grand prize" when prize#nth_before_last is 0') do
      prize.nth_before_last = 0

      with_locale(:en) do
        expect(display_draw_position(prize)).to eq('Grand prize')
      end

      with_locale(:fr) do
        expect(display_draw_position(prize)).to eq('Dernier grand prix')
      end
    end
  end
end
