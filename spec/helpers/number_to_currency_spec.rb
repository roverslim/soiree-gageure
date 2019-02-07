# frozen_string_literal: true
require 'rails_helper'

RSpec.describe('number_to_currency', type: :helper) do
  it('returns $123,456,789 when locale is :en') do
    with_locale(:en) do
      expect(number_to_currency(123_456_789.00)).to eq('$123,456,789')
    end
  end

  it('returns 123 456 789,00$ when locale is :fr') do
    with_locale(:fr) do
      expect(number_to_currency(123_456_789.00)).to eq('123 456 789 $')
    end
  end
end
