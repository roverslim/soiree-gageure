# frozen_string_literal: true
module Counters
  class LotteryDecorator
    # Input attributes
    #   - <lottery> -> ::Lottery
    def initialize(lottery)
      @lottery = lottery
    end

    delegate(
      :tickets_count,
      :registerable_tickets_count,
      :droppable_tickets_count,
      :drawable_tickets_count,
      :drawn_tickets_count,
      to: :@lottery,
    )
  end
  private_constant :LotteryDecorator
end
