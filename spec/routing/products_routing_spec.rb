# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ProductsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/markets/1/products').to route_to('products#index', market_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/markets/1/products/1').to route_to('products#show', id: '1', market_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/markets/1/products').to route_to('products#create', market_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/markets/1/products/1').to route_to('products#update', id: '1', market_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/markets/1/products/1').to route_to('products#update', id: '1', market_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/markets/1/products/1').to route_to('products#destroy', id: '1', market_id: '1')
    end
  end
end
