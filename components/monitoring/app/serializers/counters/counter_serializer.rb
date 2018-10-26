# frozen_string_literal: true
module Counters
  class CounterSerializer < ActiveModel::Serializer
    attributes :name, :count
  end
  private_constant :CounterSerializer
end
