# frozen_string_literal: true
class LotteriesController < ApplicationController
  expose :lotteries, -> { Lottery.order(event_date: :desc) }
  expose :lottery

  def index
    @lotteries = lotteries
  end

  def new
    @lottery = lottery
  end

  def create
    @lottery = lottery

    return redirect_to(lotteries_path) if lottery.save
    render(:new)
  end

  # TODO: move #show to TicketCountersController
  def show
    @lottery = lottery

    @total_num_tickets = @lottery.tickets.count
    @num_unregistered_tickets = @lottery.tickets.where(registered: false).count
    @num_tickets_in_circulation = @lottery.tickets.where(registered: true, dropped_off: false).count
    @num_tickets_in_container = @lottery.tickets.where(dropped_off: true, drawn_position: nil).count
    @num_drawn_tickets = @lottery.tickets.where.not(drawn_position: nil).count
  end

  def edit
    @lottery = lottery
  end

  def update
    @lottery = lottery

    return redirect_to(lotteries_path) if lottery.update(lottery_params)
    render(:edit)
  end

  private

  def lottery_params
    params.require(:lottery)
      .permit(:event_date, :meal_voucher_price, :ticket_price)
  end
end
