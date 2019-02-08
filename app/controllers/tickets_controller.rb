# frozen_string_literal: true
class TicketsController < ApplicationController
  expose :lottery, id: :lottery_id
  expose :tickets, -> { lottery.tickets }
  expose :ticket, scope: -> { lottery.tickets }

  before_action :assign_lottery_instance_var
  skip_before_action :authenticate_user!, only: %i(show)

  def index
    @ticket_listing = TicketListing.new(
      ticket_scope: tickets,
      number_filter: params[:number_filter],
    )

    respond_to do |format|
      format.html
      format.xlsx { render_xlsx }
    end
  end

  def new
    @ticket = ticket
  end

  def create
    builder = TicketBuilder.new(lottery: lottery)
    @ticket = builder.build(builder_params)

    return render(:new) if @ticket.errors.any?
    @ticket.save!
    redirect_to(lottery_tickets_path(lottery))
  end

  def show
    ticket = lottery.tickets.find_by(number: params[:ticket_number])
    raise(ActionController::RoutingError, 'Not Found') unless ticket

    @ticket = TicketPresenter.new(ticket: ticket, row_number: nil)
  end

  def edit
    @ticket = ticket
  end

  def update
    @builder = TicketBuilder.new(lottery: lottery)
    @ticket = @builder.build(builder_params.merge(id: params[:id]))

    return render(:edit) if @ticket.errors.any?
    @ticket.save!
    redirect_to(lottery_tickets_path(lottery))
  end

  private

  def builder_params
    ticket_params = params.fetch(:ticket, {})
      .permit(
        :number,
        :state,
        :ticket_type,
      )

    params.permit(
      :seller_name,
      :guest_name,
      :sponsor_name,
      :table_number,
    ).merge(ticket_params.to_h)
  end

  def render_xlsx
    filename = format('%s.xlsx', Ticket.model_name.human.pluralize.downcase)
    render xlsx: 'ticket_listing', filename: filename
  end

  def assign_lottery_instance_var
    @lottery = lottery
  end
end
