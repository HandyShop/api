require 'rails_helper'

RSpec.describe 'Markets', type: :request do

  JSON_FORMAT = 'application/json'

  describe 'GET /markets' do
    it 'should retrieve the market list successfully' do
      created_market = create(:market)
      get markets_path
      expect(response.content_type).to eq(JSON_FORMAT)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(created_market.name)
    end
  end

  describe 'GET /show' do

    it 'should retrieve the specified market successfully' do
      market = create(:market)
      get markets_path, params: {id: market.to_param}
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(market.name)
    end

  end

  describe 'POST /markets' do

    context 'with valid params' do
      it 'should create a market successfully' do
        market = attributes_for(:market)
        expect {
          post markets_path, params: {market: market}
        }.to change(Market, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'should respond with http status unprocessable_entity' do
        invalid_market = attributes_for(:invalid_market)
        post markets_path, params: {market: invalid_market}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  describe 'PUT /markets/:id' do

    context 'with valid params' do
      it 'should update a market successfully' do
        market = create(:market)
        another_market = attributes_for(:second_market)
        update_url = get_specific_market_url(markets_path, market.to_param)
        put update_url, params: {market: another_market}
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(another_market[:name])
      end
    end

    context 'with invalid params' do
      it 'should respond with http status unprocessable_entity' do
        market = create(:market)
        another_market = attributes_for(:invalid_market)
        update_url = get_specific_market_url(markets_path, market.to_param)
        put update_url, params: {market: another_market}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /markets/:id' do
    context 'with existing market' do
      it 'should destroys the requested market' do
        market = create(:market)
        delete_url = get_specific_market_url(markets_path, market.to_param)
        expect {
          delete delete_url
        }.to change(Market, :count).by(-1)
      end
    end

    context 'with non existing market' do
      it 'should respond to the markets list' do
        non_existing_id = 7
        delete_url = get_specific_market_url(markets_path, non_existing_id)
        delete delete_url, params: {id: non_existing_id}
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  private
  def get_specific_market_url(markets_path, market_id)
    "#{markets_path}/#{market_id}"
  end

end
