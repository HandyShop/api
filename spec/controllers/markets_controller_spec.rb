require 'rails_helper'

RSpec.describe MarketsController, type: :controller do
  
  let(:valid_attributes) {
  attributes_for(:market)
}

let(:invalid_attributes) {
attributes_for(:invalid_market)
}

# This should return the minimal set of values that should be in the session
# in order to pass any filters (e.g. authentication) defined in
# MarketsController. Be sure to keep this updated too.
let(:valid_session) { {} }

describe "GET #index" do
  it "assigns all markets as @markets" do
    market = Market.create! valid_attributes
    get :index, params: {}, session: valid_session
    expect(assigns(:markets)).to eq([market])
  end
end

describe "GET #show" do
  it "assigns the requested market as @market" do
    market = Market.create! valid_attributes
    get :show, params: {id: market.to_param}, session: valid_session
    expect(assigns(:market)).to eq(market)
  end
end

describe "POST #create" do
  context "with valid params" do
    it "creates a new Market" do
      expect {
      post :create, params: {market: valid_attributes}, session: valid_session
    }.to change(Market, :count).by(1)
  end
  
  it "assigns a newly created market as @market" do
    post :create, params: {market: valid_attributes}, session: valid_session
    expect(assigns(:market)).to be_a(Market)
    expect(assigns(:market)).to be_persisted
  end
  
  it "redirects to the created market" do
    post :create, params: {market: valid_attributes}, session: valid_session
    expect(response).to have_http_status(:created)
  end
end

context "with invalid params" do
  it "assigns a newly created but unsaved market as @market" do
    post :create, params: {market: invalid_attributes}, session: valid_session
    expect(assigns(:market)).to be_a_new(Market)
  end
  
  # TODO: Discuss about what should be the error in this case
  # it "respond with an error" do
    #   post :create, params: {market: invalid_attributes}, session: valid_session
    #   expect(response).to render_template("new")
    # end
  end
end

describe "PUT #update" do
  context "with valid params" do
    let(:new_attributes) {
    attributes_for(:second_market)
  }
  
  it "updates the requested market" do
    market = Market.create! valid_attributes
    put :update, params: {id: market.to_param, market: new_attributes}, session: valid_session
    market.reload
    expect(market.name).to eq(new_attributes[:name])
  end
  
  it "assigns the requested market as @market" do
    market = Market.create! valid_attributes
    put :update, params: {id: market.to_param, market: valid_attributes}, session: valid_session
    expect(assigns(:market)).to eq(market)
  end
  
  it "redirects to the market" do
    market = Market.create! valid_attributes
    put :update, params: {id: market.to_param, market: valid_attributes}, session: valid_session
    expect(response).to have_http_status(:ok)
  end
end

context "with invalid params" do
  it "assigns the market as @market" do
    market = Market.create! valid_attributes
    put :update, params: {id: market.to_param, market: invalid_attributes}, session: valid_session
    expect(assigns(:market)).to eq(market)
  end
  
  # TODO: Discuss about what should be the error in this case
  # it "re-renders the 'edit' template" do
    #   market = Market.create! valid_attributes
    #   put :update, params: {id: market.to_param, market: invalid_attributes}, session: valid_session
    #   expect(response).to render_template("edit")
    # end
  end
end

describe "DELETE #destroy" do
  it "destroys the requested market" do
    market = Market.create! valid_attributes
    expect {
    delete :destroy, params: {id: market.to_param}, session: valid_session
  }.to change(Market, :count).by(-1)
end

it "redirects to the markets list" do
  market = Market.create! valid_attributes
  delete :destroy, params: {id: market.to_param}, session: valid_session
  expect(response).to have_http_status(:no_content)
end
end

end
