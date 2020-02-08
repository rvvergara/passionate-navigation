# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :verticals, except: %i[new edit]
    resources :categories, except: %i[new edit]
    resources :courses, except: %i[new edit]
    resources :sessions, only: %i[create]
  end
end
