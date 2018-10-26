# frozen_string_literal: true
module Counters
  class Counter
    include ActiveModel::Serialization

    # Input attributes
    #   - <lottery> -> Counters::LotteryDecorator
    #   - <name> -> String or Symbol
    def initialize(lottery:, name:)
      @lottery = lottery
      @name = name
    end

    def name
      I18n.t("lotteries.#{@name}")
    end

    def count
      counter = "#{@name}_count"
      @lottery.public_send(counter)
    end
  end
  private_constant :Counter
end
