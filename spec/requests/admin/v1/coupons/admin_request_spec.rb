require 'rails_helper'

RSpec.describe "Admin::V1::Coupons as :admin", type: :request do
  let(:user) { create(:user) }


  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupon, 10) }
    
    context "without params" do

      it 'returns 10 coupons' do
        get url, headers: auth_header(user)
        expect(body_json['coupons']).to contain_exactly *coupons.as_json(only: %i(id name code status discount_value due_date))
      end
      
      it 'returns success status' do
        get url, headers: auth_header(user)
        expect(response).to have_http_status(:ok)
      end

    end

  end

  context "POST /coupons" do
    let(:url) { "/admin/v1/coupons" }

    context "with valid params" do
      let!(:coupon_params) { { coupon: attributes_for(:coupon) }.to_json }

      it 'when adds a new coupon' do 
        expect do
          post url, headers: auth_header(user), params: coupon_params
        end.to change(Coupon, :count).by(1)
      end

      it 'returns success status' do
        post url, headers: auth_header(user), params: coupon_params
        expect(response).to have_http_status(:ok)
      end

      it 'returns last added coupon' do
        post url, headers: auth_header(user), params: coupon_params
        last_coupon = Coupon.last.as_json(only: %i(id name code status discount_value due_date))
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

      it 'returns error messages' do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

    end

  end

  context "PATCH /coupons/:id" do
    let(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}"}

    context "with valid params" do
      let(:new_name) { 'New Coupon' }
      let(:coupon_params) { { coupon: { name: new_name } }.to_json }

      it 'updates coupon' do
        patch url, headers: auth_header(user), params: coupon_params
        coupon.reload
        expect(coupon.name).to eq new_name
      end

      it 'returns updated coupon' do
        patch url, headers: auth_header(user), params: coupon_params
        coupon.reload
        updated_coupon = coupon.as_json(only: %i(id name code status discount_value due_date))
        expect(body_json['coupon']).to eq updated_coupon
      end

      it 'returns success status' do
        patch url, headers: auth_header(user), params: coupon_params
        expect(response).to have_http_status(:ok)
      end

    end

    context "with invalid params" do
      let(:coupon_invalid_params) { { coupon: attributes_for(:coupon, name: nil)}.to_json }

      it 'does not updates the coupon' do
        old_name = coupon.name
        patch url, headers: auth_header(user), params: coupon_invalid_params
        coupon.reload
        expect(coupon.name).to eq old_name
      end

      it 'returns unprocessable_entity status' do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

    end

  end

  context "DELETE /coupons/:id" do
    let!(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}"}

    it 'when deleting the user' do
      expect do
        delete url, headers: auth_header(user)
      end.to change(Coupon, :count).by(-1)
    end

    it 'return success status' do
      delete url, headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end

    it 'does not return anybody content' do
      delete url, headers: auth_header(user)
      expect(body_json).to_not be_present
    end

  end

end
