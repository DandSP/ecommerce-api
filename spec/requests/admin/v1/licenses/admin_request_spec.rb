require 'rails_helper'

RSpec.describe "Admin::V1::Licenses as :admin", type: :request do
  let(:user) { create(:user) }
  let(:game) { create(:game) }

  context "GET /games/:game_id/licenses" do
    let(:url) { "/admin/v1/games/#{game.id}/licenses" }
    let!(:licenses) { create_list(:license, 10, game: game) }

    context "without any params" do

      it 'returns 10 licenses' do
        get url, headers: auth_header(user)
        expect(body_json['licenses'].count).to eq 10
      end

      it "returns 10 first Licenses" do
        get url, headers: auth_header(user)
        expected_licenses = licenses[0..9].as_json(only: %i(id key status game_id))
        expect(body_json['licenses']).to contain_exactly *expected_licenses
      end

      it 'returns sucess status' do
        get url, headers: auth_header(user)
        expect(response).to have_http_status(:ok)
      end

    end
    
  end

  context "POST /games/:game_id/licenses" do
    let(:game) { create(:game) }
    let(:url) { "/admin/v1/games/#{game.id}/licenses" }

    context "with valid params" do
      let!(:license_params) { { license: attributes_for(:license)}.to_json }

      it 'added a new license' do
        expect do
          post url, headers: auth_header(user), params: license_params
        end.to change(License, :count).by(1)
      end

      it 'returns last added license' do
        post url, headers: auth_header(user), params: license_params
        expected_license = License.last.as_json(only: %i(id key status game_id))
        expect(body_json['license']).to eq expected_license
      end 

      it 'returns sucess status' do
        post url, headers: auth_header(user), params: license_params
        expect(response).to have_http_status(:ok)
      end

    end

    context "with invalid params" do  
      let!(:license_invalid_params) { { license: attributes_for(:license, key: nil) }.to_json }

      it 'does not add a new license' do
        expect do
          post url, headers: auth_header(user), params: license_invalid_params
        end.to_not change(License, :count)
      end

      it 'returns error messages' do
        post url, headers: auth_header(user), params: license_invalid_params
        expect(body_json['errors']['fields']).to have_key('key')
      end

      it 'returns unprocessable_entity status' do
        post url, headers: auth_header(user), params: license_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

  end

  context "GET /licenses/:id" do
    let!(:license) { create(:license) }
    let(:url) { "/admin/v1/licenses/#{license.id}" }
    
    it 'returns the same license' do
      get url, headers: auth_header(user)
      expected_license = license.as_json(only: %i(id key status game_id))
      expect(body_json['license']).to eq expected_license
    end

    it 'returns sucess status' do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end

  end

  context "PATCH /licenses/:id" do
    let(:license) { create(:license) }
    let(:url) { "/admin/v1/licenses/#{license.id}" }

    context "with valid params" do
      let(:new_key) { 'New Key' }
      let(:license_params) { { license: { key: new_key} }.to_json }

      it 'updates license key' do
        patch url, headers: auth_header(user), params: license_params
        license.reload
        expect(license.key).to eq new_key
      end

      it 'returns updated License' do
        patch url, headers: auth_header(user), params: license_params
        license.reload
        expected_license = license.as_json(only: %i(id key platform status game_id))
        expect(body_json['license']).to eq expected_license
      end

      it 'returns success status' do
        patch url, headers: auth_header(user), params: license_params
        expect(response).to have_http_status(:ok)
      end

    end

    context "with invalid params" do
      let(:license_invalid_params) { { license: { key: nil } }.to_json }

      it 'returns licenses old key' do
        old_key = license.key
        patch url, headers: auth_header(user), params: license_invalid_params
        license.reload
        expect(license.key).to eq old_key
      end

      it 'returns error messages' do
        patch url, headers: auth_header(user), params: license_invalid_params
        expect(body_json['errors']['fields']).to have_key('key')
      end

      it 'returns unprocessable_entity status' do
        patch url, headers: auth_header(user), params: license_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

  end

  context "DELETE /licenses/:id" do
    let!(:license) { create(:license) }
    let(:url) { "/admin/v1/licenses/#{license.id}"}

    it 'removes license' do
      expect do
        delete url, headers: auth_header(user)
      end.to change(License, :count).by(-1)
    end

    it 'does not return anybody count' do
      delete url, headers: auth_header(user)
      expect(body_json).to_not be_present
    end

    it 'returns no_content status' do
      delete url, headers: auth_header
      expect(response).to have_http_status(:no_content)
    end

  end
  
end
