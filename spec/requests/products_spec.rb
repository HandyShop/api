require 'rails_helper'

RSpec.describe 'Products', type: :request do

  before(:each) do
    @market_id = create_market_returning_id
  end

  describe 'GET /markets/:market_id/products' do
    context 'with an existing product and market' do
      it 'should retrieve the product list from a market successfully' do
        product = create_valid_product(@market_id)
        products_url = get_products_market_url(@market_id)
        get products_url
        expect(response).to have_http_status(:ok)
        expect_response_have_product(response, product)
      end
    end

    context 'with a non existing market' do
      it 'should retrieve http status not_found' do
        @market_id = -1
        products_url = get_products_market_url(@market_id)
        get products_url
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /markets/:market_id/products/:product_id' do
    context 'with an existing product' do
      it 'should retrieve a specific product from a market successfully' do
        product = create_valid_product(@market_id)
        products_url = get_specific_product_url(@market_id, product.to_param)
        get products_url
        expect(response).to have_http_status(:ok)
        expect_response_have_product(response, product)
      end
    end

    context 'with a non existing product' do
      it 'should respond with http status not_found' do
        non_existing_id = -1
        products_url = get_specific_product_url(@market_id, non_existing_id)
        get products_url
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with a non existing market' do
      it 'should retrieve http status not_found' do
        product = create_valid_product(@market_id)
        @market_id = -1
        products_url = get_specific_product_url(@market_id, product.to_param)
        get products_url
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /markets/:market_id/products' do
    context 'with valid params' do
      it 'creates a new Product' do
        valid_product = attributes_for(:product)
        products_url = get_products_market_url(@market_id)
        expect {
          post products_url, params: {product: valid_product}
        }.to change(Product, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'respond with http status unprocessable_entity' do
        invalid_product = attributes_for(:invalid_product)
        products_url = get_products_market_url(@market_id)
        post products_url, params: {product: invalid_product}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with a non existing market' do
      it 'should retrieve http status not_found' do
        @market_id = -1
        valid_product = attributes_for(:product)
        products_url = get_products_market_url(@market_id)
        post products_url, params: {product: valid_product}
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT /markets/:market_id/products/:product_id' do
    context 'with valid params' do
      it 'updates the requested product' do
        product = create_valid_product(@market_id)
        another_product = attributes_for(:second_product)
        product_url = get_specific_product_url(@market_id, product.to_param)
        put product_url, params: {product: another_product, market_id: @market_id}
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
        product_url = get_specific_product_url(@market_id, product.to_param)
        put product_url, params: {product: invalid_product, market_id: @market_id}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with a non existing market' do
      it 'should retrieve http status not_found' do
        product = create_valid_product(@market_id)
        another_product = attributes_for(:second_product)
        @market_id = -1
        product_url = get_specific_product_url(@market_id, product.to_param)
        put product_url, params: {product: another_product, market_id: @market_id}
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /markets/:market_id/products/:product_id' do
    context 'with an existing product' do
      it 'destroys the requested product' do
        product = create_valid_product(@market_id)
        product_url = get_specific_product_url(@market_id, product.to_param)
        expect {
          delete product_url
        }.to change(Product, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with a non existing product' do
      it 'responds with http status not_found' do
        non_existing_id = -1
        product_url = get_specific_product_url(@market_id, non_existing_id)
        delete product_url
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with a non existing market' do
      it 'should retrieve http status not_found' do
        product = create_valid_product(@market_id)
        @market_id = -1
        product_url = get_specific_product_url(@market_id, product.to_param)
        delete product_url
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

  def get_products_market_url(market_id)
    "/markets/#{market_id}/products"
  end

  def get_specific_product_url(market_id, product_id)
    "/markets/#{market_id}/products/#{product_id}"
  end

  def expect_response_have_product(response, product)
    expect(response.body).to include(product.name)
    expect(response.body).to include(product.price.to_s)
    expect(response.body).to include(product.description)
    expect(response.body).to include(product.quantity.to_s)
  end

end
