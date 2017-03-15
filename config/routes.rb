# frozen_string_literal: true
Rails.application.routes.draw do
  resources :markets do
    resources :products
  end
end
