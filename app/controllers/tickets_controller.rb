# frozen_string_literal: true
class TicketsController < ApplicationController
  expose :lottery, id: :lottery_id
  before_action :fixme_set_lottery_instance_var

  def index
    @ticket_listing = TicketListing.new(
      ticket_scope: lottery.tickets,
      number_filter: params[:number_filter],
    )

    respond_to do |format|
      format.html
      format.xlsx { render_xlsx }
    end
  end

  def new
    @ticket = lottery.tickets.new
  end

  def create
    builder = TicketBuilder.new(lottery: lottery)
    @ticket = builder.build(builder_params)

    return(render(:new)) if @ticket.errors.any?
    @ticket.save!
    redirect_to(lottery_tickets_path(lottery))
  end

  def edit
    @ticket = lottery.tickets.find(params[:id])
  end

  def update
    @builder = TicketBuilder.new(lottery: lottery)
    @ticket = @builder.build(builder_params.merge(id: params[:id]))

    return(render(:edit)) if @ticket.errors.any?
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

  def fixme_set_lottery_instance_var
    @lottery = lottery
  end
end
