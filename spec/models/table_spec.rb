# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Table, type: :model) do
  let(:lottery) do
    Lottery.create!(event_date: Time.zone.today)
  end

  let(:table) do
    Table.create!(
      lottery: lottery,
      number: 1,
      capacity: 6,
    )
  end

  describe('#lottery_id') do
    it('is read-only') do
      other_lottery = Lottery.create!(event_date: Time.zone.tomorrow)
      expect { table.update!(lottery_id: other_lottery.id) }
        .not_to(change { table.reload.lottery_id })
    end
  end

  describe('#number') do
    it('is indexed') do
      expect(
        ActiveRecord::Base.connection.index_exists?(:tables, :number),
      ).to be(true)
    end

    it('is unique per lottery') do
      expect(
        ActiveRecord::Base.connection.index_exists?(
          :tables,
          %i(lottery_id number),
          unique: true,
        ),
      ).to be(true)
    end
  end

  describe('#valid?') do
    it('requires a lottery') do
      new_table = Table.new
      expect(new_table).not_to be_valid

      with_locale(:en) do
        new_table.valid?
        expect(new_table.errors[:lottery]).to include('must exist')
      end

      with_locale(:fr) do
        new_table.valid?
        expect(new_table.errors[:lottery]).to include('doit être spécifié')
      end
    end

    it('requires :number to be a number') do
      new_table = Table.new
      expect(new_table).not_to be_valid

      with_locale(:en) do
        new_table.valid?
        expect(new_table.errors[:number]).to include('is not a number')
      end

      with_locale(:fr) do
        new_table.valid?
        expect(new_table.errors[:number]).to include('doit être un chiffre')
      end
    end

    it('requires :number to be an integer') do
      new_table = Table.new(number: 3.3)
      expect(new_table).not_to be_valid

      with_locale(:en) do
        new_table.valid?
        expect(new_table.errors[:number]).to include('must be an integer')
      end

      with_locale(:fr) do
        new_table.valid?
        expect(new_table.errors[:number]).to include('doit être un nombre entier')
      end
    end

    it('requires :number to be greater than 0') do
      new_table = Table.new(number: 0)
      expect(new_table).not_to be_valid

      with_locale(:en) do
        new_table.valid?
        expect(new_table.errors[:number]).to include('must be greater than 0')
      end

      with_locale(:fr) do
        new_table.valid?
        expect(new_table.errors[:number]).to include('doit être supérieur à 0')
      end
    end

    it('requires :number to be unique per lottery') do
      new_table = Table.new(
        lottery: lottery,
        number: table.number,
        capacity: 5,
      )
      expect(new_table).not_to be_valid

      with_locale(:en) do
        new_table.valid?
        expect(new_table.errors[:number]).to include('has already been taken')
      end

      with_locale(:fr) do
        new_table.valid?
        expect(new_table.errors[:number]).to include('a déjà été assigné')
      end
    end

    it('requires :capacity to be a capacity') do
      new_table = Table.new
      expect(new_table).not_to be_valid

      with_locale(:en) do
        new_table.valid?
        expect(new_table.errors[:capacity]).to include('is not a number')
      end

      with_locale(:fr) do
        new_table.valid?
        expect(new_table.errors[:capacity]).to include('doit être un chiffre')
      end
    end

    it('requires :capacity to be an integer') do
      new_table = Table.new(capacity: 3.3)
      expect(new_table).not_to be_valid

      with_locale(:en) do
        new_table.valid?
        expect(new_table.errors[:capacity]).to include('must be an integer')
      end

      with_locale(:fr) do
        new_table.valid?
        expect(new_table.errors[:capacity]).to include('doit être un nombre entier')
      end
    end

    it('requires :capacity to be greater than 0') do
      new_table = Table.new(capacity: 0)
      expect(new_table).not_to be_valid

      with_locale(:en) do
        new_table.valid?
        expect(new_table.errors[:capacity]).to include('must be greater than 0')
      end

      with_locale(:fr) do
        new_table.valid?
        expect(new_table.errors[:capacity]).to include('doit être supérieur à 0')
      end
    end
  end

  describe('#lottery') do
    it('returns the parent lottery') do
      expect(table.lottery).to eq(lottery)
    end
  end
end
