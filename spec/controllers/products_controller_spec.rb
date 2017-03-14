require 'rails_helper'
RSpec.describe ProductsController, type: :controller do

  let(:valid_attributes) {
    attributes_for(:product)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_product)
  }

  let(:valid_market) {
    attributes_for(:market)
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all products as @products" do
      market_id = create_market_returning_id
      product = create_product(valid_attributes, market_id)
      get :index, params: {market_id: market_id}, session: valid_session
      expect(assigns(:products)).to eq([product])
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      market_id = create_market_returning_id
      product = create_product(valid_attributes, market_id)
      get :show, params: {id: product.to_param, market_id: market_id}, session: valid_session
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        market_id = create_market_returning_id
        expect {
          post :create, params: {product: valid_attributes, market_id: market_id}, session: valid_session
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        market_id = create_market_returning_id
        post :create, params: {product: valid_attributes, market_id: market_id}, session: valid_session
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it "respond with http status 'created'" do
        market_id = create_market_returning_id
        post :create, params: {product: valid_attributes, market_id: market_id}, session: valid_session
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        market_id = create_market_returning_id
        post :create, params: {product: invalid_attributes, market_id: market_id}, session: valid_session
        expect(assigns(:product)).to be_a_new(Product)
      end

      it "respond with an error" do
        market_id = create_market_returning_id
        post :create, params: {product: invalid_attributes, market_id: market_id}, session: valid_session
      expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:second_product)
      }

      it "updates the requested product" do
        market_id = create_market_returning_id
        product = create_product(valid_attributes, market_id)
        put :update, params: {id: product.to_param, product: new_attributes, market_id: market_id}, session: valid_session
        product.reload
        expect(product.name).to eq(new_attributes[:name])
        expect(product.price).to eq(new_attributes[:price])
        expect(product.quantity).to eq(new_attributes[:quantity])
        expect(product.description).to eq(new_attributes[:description])
        expect(product.barcode).to eq(new_attributes[:barcode])
      end

      it "assigns the requested product as @product" do
        market_id = create_market_returning_id
        product = create_product(valid_attributes, market_id)
        put :update, params: {id: product.to_param, product: valid_attributes, market_id: market_id}, session: valid_session
        expect(assigns(:product)).to eq(product)
      end

      it "redirects to the product" do
        market_id = create_market_returning_id
        product = create_product(valid_attributes, market_id)
        put :update, params: {id: product.to_param, product: valid_attributes, market_id: market_id}, session: valid_session
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "assigns the product as @product" do
        market_id = create_market_returning_id
        product = create_product(valid_attributes, market_id)
        put :update, params: {id: product.to_param, product: invalid_attributes, market_id: market_id}, session: valid_session
        expect(assigns(:product)).to eq(product)
      end

      it "respond with an error" do
        market_id = create_market_returning_id
        product = create_product(valid_attributes, market_id)
        put :update, params: {id: product.to_param, product: invalid_attributes, market_id: market_id}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      market_id = create_market_returning_id
      product = create_product(valid_attributes, market_id)
      expect {
        delete :destroy, params: {id: product.to_param, market_id: market_id}, session: valid_session
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      market_id = create_market_returning_id
      product = create_product(valid_attributes, market_id)
      delete :destroy, params: {id: product.to_param, market_id: market_id}, session: valid_session
      expect(response).to have_http_status(:no_content)
    end
  end

  private
  def create_market_returning_id
    market = Market.create valid_market
    market.id
  end

  def create_product(attributes, market_id)
    Product.create! attributes.merge({market_id: market_id})
  end

end
