class TicketDropOffsController < ApplicationController
  include LotteryLookup

  def index
    @number = params[:number]
    @tickets = tickets_for_drop_off.includes(:guest).order(:number)
    @tickets = @tickets.where(number: @number) if @number.present?

    render(
      'lotteries/lottery_child_index',
      locals: { main_partial: 'ticket_drop_offs/index' },
    )
  end

  def update
    return head(:no_content) if @lottery.locked?

    @ticket = tickets_for_drop_off.find(params[:id])
    @ticket.update_attributes(dropped_off: true)
    redirect_to(lottery_ticket_drop_offs_path(@lottery))
  end

  private

  def tickets_for_drop_off
    @lottery.tickets.where(
      registered: true,
      dropped_off: false,
    )
  end
end
