require 'rails_helper'

RSpec.describe "Admin::V1::Coupons as :admin", type: :request do
  let(:user) { create(:user) }


  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupon, 10) }
    
    context "Without params" do

      it 'returns 10 coupons' do
        get url, headers: auth_header(user)
        expect(body_json['coupons']).to contain_exactly *coupons.as_json(only: %i(id name))
      end
      
      it 'returns success status' do
        get url, headers: auth_header(user)
        expect(response).to have_http_status(:ok)
      end

    end

  end

  context "POST /coupons" do
    let(:url) { "/admin/v1/coupons" }

    context "With valid params" do
      let(:coupon_params) { {coupon: attributes_for(:coupon)}.to_json }

      it 'returns success status' do
        post url, headers: auth_header(user), params: coupon_params
        puts response.body
        expect(response).to have_http_status(:ok)
      end

      it 'When adds a new coupon' do 
        expect do
          post url, headers: auth_header(user), params: coupon_params
        end.to change(Coupon, :count).by(1)
        expect(response).to have_http_status(:ok)
      end

      it 'returns last coupon' do
        post url, headers: auth_header(user), params: coupon_params
        last_coupon = Coupon.last.as_json(only: %i(id name))
        expect(body_json['coupon']).to eq last_coupon
      end

    end

    context "with invalid params" do
      let(:coupon_invalid_params) { {coupon: attributes_for(:coupon, name: nil)}.to_json }

      it 'does not adds a new coupon' do
        expect do
          post url, headers: auth_header(user), params: coupon_invalid_params
        end.to_not change(Coupon, :count)
      end

      it 'returns unprocessable_entity status' do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

  end


end
