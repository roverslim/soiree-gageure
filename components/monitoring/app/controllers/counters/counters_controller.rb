# frozen_string_literal: true
module Counters
  class CountersController < ApplicationController
    expose(
      :lottery,
      id: :lottery_id,
      decorate: ->(lottery) { LotteryDecorator.new(lottery) },
    )

    def show
      name = params[:name]
      counter = Counter.new(
        lottery: lottery,
        name: name,
      )
      render(json: counter, serializer: CounterSerializer)
    end
  end
end
