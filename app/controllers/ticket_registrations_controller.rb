class TicketRegistrationsController < ApplicationController
  include LotteryLookup

  def index
    @number = params[:number]
    @tickets = ticket_for_registration.includes(:guest, :table).order(:number)
    @tickets = @tickets.where(number: @number) if @number.present?

    render(
      'lotteries/lottery_child_index',
      locals: { main_partial: 'ticket_registrations/index' },
    )
  end

  def edit
    return head(:no_content) if @lottery.locked?
    @ticket = ticket_for_registration.find(params[:id])
  end

  def update
    return head(:no_content) if @lottery.locked?

    @builder = TicketBuilder.new(lottery: @lottery)
    ticket = ticket_for_registration.find(params[:id])
    @ticket = @builder.build(builder_params.merge(id: ticket.id))

    @ticket = TicketRegistrationValidator.validate(@ticket)
    return render(:edit) if @ticket.errors.any?

    @ticket.registered = true
    @ticket.save!
    redirect_to(lottery_ticket_registrations_path(@lottery))
  end

  private

  def ticket_for_registration
    @lottery.tickets
      .where(registered: false)
      .where.not(state: 'reserved')
  end

  def builder_params
    params.permit(
      :guest_name,
      :table_number,
    )
  end
end
