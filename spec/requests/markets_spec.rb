# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Markets', type: :request do
  JSON_FORMAT = 'application/json'
  INVALID_ID = -1

  describe 'GET /markets' do
    it 'retrieves the market list successfully' do
      created_market = create(:market)
      get markets_path
      expect(response.content_type).to eq(JSON_FORMAT)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(created_market.name)
    end
  end

  describe 'GET /markets/:id' do
    context 'with an existing market' do
      it 'retrieves the specified market successfully' do
        market = create(:market)
        get market_path(market.to_param)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(market.name)
      end
    end

    context 'with a non existing market' do
      it 'responds with http status not found' do
        non_existing_id = INVALID_ID
        get market_path(non_existing_id)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /markets' do
    context 'with valid params' do
      it 'creates a market successfully' do
        market = attributes_for(:market)
        expect {
          post markets_path, params: { market: market }
        }.to change(Market, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'responds with http status unprocessable_entity' do
        invalid_market = attributes_for(:invalid_market)
        post markets_path, params: { market: invalid_market }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /markets/:id' do
    context 'with valid params' do
      it 'updates a market successfully' do
        market = create(:market)
        another_market = attributes_for(:market)
        put market_path(market.to_param), params: { market: another_market }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(another_market[:name])
      end
    end

    context 'with invalid params' do
      it 'responds with http status unprocessable_entity' do
        market = create(:market)
        another_market = attributes_for(:invalid_market)
        put market_path(market.to_param), params: { market: another_market }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with a non existing market' do
      it 'responds with http status not_found' do
        non_existing_id = INVALID_ID
        another_market = attributes_for(:market)
        put market_path(non_existing_id), params: { market: another_market }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /markets/:id' do
    context 'with existing market' do
      it 'destroys the requested market' do
        market = create(:market)
        expect {
          delete market_path(market.to_param)
        }.to change(Market, :count).by(-1)
      end
    end

    context 'with non existing market' do
      it 'responds to the markets list' do
        non_existing_id = INVALID_ID
        delete market_path(non_existing_id)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
