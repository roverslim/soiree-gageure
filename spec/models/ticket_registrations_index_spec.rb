# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(TicketRegistrationsIndex, type: :model) do
  include I18nSpecHelper

  describe('#number_filter') do
    it('returns the number filter') do
      @number_filter = double
      expect(index.number_filter).to be(@number_filter)
    end
  end

  describe('#tickets_to_display?') do
    it('returns true when tickets are present') do
      @tickets = [double]
      expect(index.tickets_to_display?).to be(true)
    end

    it('returns false when tickets are missing') do
      @tickets = []
      expect(index.tickets_to_display?).to be(false)
    end
  end

  describe('#each') do
    it('yields when tickets are present') do
      @tickets = [double]
      expect { |b| index.each(&b) }
        .to(yield_control)
    end

    it('returns nil when tickets are missing') do
      @tickets = []
      expect { |b| index.each(&b) }
        .not_to(yield_control)
    end
  end

  describe('#no_tickets_message') do
    it('returns nil when tickets are present') do
      @tickets = [double]
      expect(index.no_tickets_message).to be_nil
    end

    context('when tickets are missing') do
      before(:each) do
        @tickets = []
      end

      context('the locale is :en') do
        around(:each) do |example|
          with_locale(:en) { example.run }
        end

        it('returns a message when the number filter is present') do
          @number_filter = '123'
          expect(index.no_tickets_message).to eq('Ticket #123 can\'t be registered.')
        end

        it('returns a message when the number filter is missing') do
          @number_filter = nil
          expect(index.no_tickets_message).to eq('There are no unregistered tickets.')
        end
      end

      context('the locale is :fr') do
        around(:each) do |example|
          with_locale(:fr) { example.run }
        end

        it('returns a message when the number filter is present') do
          @number_filter = '123'
          expect(index.no_tickets_message).to eq('Le billet no.123 ne peut pas être enregistré.')
        end

        it('returns a message when the number filter is missing') do
          @number_filter = nil
          expect(index.no_tickets_message).to eq('Il n\'y a pas de billets à enregistrer.')
        end
      end
    end
  end

  private

  def index
    TicketRegistrationsIndex.new(
      tickets: @tickets,
      number_filter: @number_filter,
    )
  end
end
