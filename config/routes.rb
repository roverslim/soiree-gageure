# frozen_string_literal: true

Rails.application.routes.draw do
  scope('/:locale', locale: /en|fr/) do
    devise_for(:users)
  end

  scope('(/:locale)', locale: /en|fr/) do
    with_options(
      only: %i(index new create edit update),
    ) do |actions|
      resources(:lotteries, only: %i(index new create edit show update)) do
        actions.resources(:prizes)
        actions.resources(:tickets)
        resources(:tables, only: %i(index new create edit show update))
        resources(:ticket_registrations, only: %i(index edit update))
        resources(:ticket_impressions, only: %i(index show))
        resources(:ticket_drop_offs, only: %i(index update))
        resources(:ticket_draws, only: %i(index update))
        resources(:drawn_tickets, only: %i(index update))
        resources(:results, only: :index)
        resources(:results_dashboards, only: :index)
      end
      actions.resources(:sellers)
      actions.resources(:guests)
      actions.resources(:sponsors)
      actions.resources(:users)
    end
    resources(:lock_lotteries, only: :update)

    with_options(defaults: { format: :json }) do
      get('seller_names', to: 'sellers#index')
      get('guest_names', to: 'guests#index')
      get('sponsor_names', to: 'sponsors#index')
    end

    get '/preview/2019/:ticket_number' => 'tickets#show', lottery_id: 3
  end

  get '/:locale' => 'lotteries#index', locale: /en|fr/
  root 'lotteries#index'

  mount(ActionCable.server => '/cable')
end
