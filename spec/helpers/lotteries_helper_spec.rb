# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(LotteriesHelper, type: :helper) do
  let(:lottery) do
    Lottery.create!(event_date: Time.zone.today)
  end

  describe('#lock_or_unlock') do
    context('when lottery#locked == false') do
      it('returns "Lock registration" when locale: en') do
        with_locale(:en) do
          assert_equal('Lock registration', lock_or_unlock(lottery))
        end
      end

      it("returns 'Fermer l'enregistrement' when locale: fr") do
        with_locale(:fr) do
          assert_equal("Fermer l'enregistrement", lock_or_unlock(lottery))
        end
      end
    end

    context('when lottery#locked == true') do
      before(:each) do
        lottery.update!(locked: true)
      end

      it('returns "Unlock registration" when locale: en') do
        with_locale(:en) do
          assert_equal('Unlock registration', lock_or_unlock(lottery))
        end
      end

      it("returns 'Réouvrir l'enregistrement' when lottery#locked == true") do
        with_locale(:fr) do
          assert_equal("Réouvrir l'enregistrement", lock_or_unlock(lottery))
        end
      end
    end
  end
end
