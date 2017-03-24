# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Products', type: :request do
  INVALID_ID = -1

  before do
    @market_id = create_market_returning_id
  end

  describe 'GET /markets/:market_id/products' do
    context 'with an existing product and market' do
      it 'retrieves the product list from a market successfully' do
        product = create_valid_product(@market_id)
        get market_products_path(@market_id)
        expect(response).to have_http_status(:ok)
        expect_response_have_product(response, product)
      end
    end

    context 'with a non existing market' do
      it 'retrieves http status not_found' do
        @market_id = INVALID_ID
        get market_products_path(@market_id)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /markets/:market_id/products/:product_id' do
    context 'with an existing product' do
      it 'retrieves a specific product from a market successfully' do
        product = create_valid_product(@market_id)
        get market_product_path(@market_id, product.to_param)
        expect(response).to have_http_status(:ok)
        expect_response_have_product(response, product)
      end
    end

    context 'with a non existing product' do
      it 'responds with http status not_found' do
        non_existing_id = INVALID_ID
        get market_product_path(@market_id, non_existing_id)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with a non existing market' do
      it 'retrieves http status not_found' do
        product = create_valid_product(@market_id)
        @market_id = INVALID_ID
        get market_product_path(@market_id, product.to_param)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /markets/:market_id/products' do
    context 'with valid params' do
      it 'creates a new Product' do
        valid_product = attributes_for(:product)
        expect {
          post market_products_path(@market_id), params: { product: valid_product }
        }.to change(Product, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'respond with http status unprocessable_entity' do
        invalid_product = attributes_for(:invalid_product)
        post market_products_path(@market_id), params: { product: invalid_product }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with a non existing market' do
      it 'retrieves http status not_found' do
        @market_id = INVALID_ID
        valid_product = attributes_for(:product)
        post market_products_path(@market_id), params: { product: valid_product }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT /markets/:market_id/products/:product_id' do
    context 'with valid params' do
      it 'updates the requested product' do
        product = create_valid_product(@market_id)
        another_product = attributes_for(:product)
        put market_product_path(@market_id, product.to_param), params: { product: another_product, market_id: @market_id }
        product.reload
        expect(product.name).to eq(another_product[:name])
        expect(product.price).to eq(another_product[:price])
        expect(product.quantity).to eq(another_product[:quantity])
        expect(product.description).to eq(another_product[:description])
        expect(product.barcode).to eq(another_product[:barcode])
      end
    end

    context 'with invalid params' do
      it 'assigns the product as @product' do
        product = create_valid_product(@market_id)
        invalid_product = attributes_for(:invalid_product)
        put market_product_path(@market_id, product.to_param), params: { product: invalid_product, market_id: @market_id }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with a non existing market' do
      it 'retrieves http status not_found' do
        product = create_valid_product(@market_id)
        another_product = attributes_for(:product)
        @market_id = INVALID_ID
        put market_product_path(@market_id, product.to_param), params: { product: another_product, market_id: @market_id }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /markets/:market_id/products/:product_id' do
    context 'with an existing product' do
      it 'destroys the requested product' do
        product = create_valid_product(@market_id)
        expect {
          delete market_product_path(@market_id, product.to_param)
        }.to change(Product, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with a non existing product' do
      it 'responds with http status not_found' do
        non_existing_id = INVALID_ID
        delete market_product_path(@market_id, non_existing_id)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with a non existing market' do
      it 'retrieves http status not_found' do
        product = create_valid_product(@market_id)
        @market_id = INVALID_ID
        delete market_product_path(@market_id, product.to_param)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  private

  def create_market_returning_id
    market = create(:market)
    market.id
  end

  def create_product(attributes, market_id)
    create(attributes, market_id: market_id)
  end

  def create_valid_product(market_id)
    create_product(:product, market_id)
  end

  def create_invalid_product(market_id)
    create_product(:invalid_product, market_id)
  end

  def expect_response_have_product(response, product)
    expect(response.body).to include(product.name)
    expect(response.body).to include(product.price.to_s)
    expect(response.body).to include(product.description)
    expect(response.body).to include(product.quantity.to_s)
  end
end
