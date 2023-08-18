require 'rails_helper'

RSpec.describe "Admin::V1::Licenses as :client", type: :request do
  let(:user) { create(:user, profile: :client) }
  let(:game) { create(:game) }

  context "GET /games/:game_id/licenses" do

    let(:url) { "/admin/v1/games/#{game.id}/licenses" }
    let!(:license) { create_list(:license, 10) }

    before(:each) { get url, headers: auth_header(user) }

    include_examples "forbidden access"

  end

  context "POST /games/:game_id/licenses" do
    let(:url) { "/admin/v1/games/#{game.id}/licenses" }
    let!(:license_params) { { license: attributes_for(:license)}.to_json }

    before(:each) { post url, headers: auth_header(user), params: license_params }

    include_examples "forbidden access"

  end

  context "GET /licenses/:id" do
    let!(:license) { create(:license) }
    let(:url) { "/admin/v1/licenses/#{license.id}"}

    before(:each) { get url, headers: auth_header(user)}

    include_examples "forbidden access"
    
  end

  context "PATCH /licenses:id" do
    let!(:license) { create(:license) }
    let(:url) { "/admin/v1/licenses/#{license.id}"}

    before(:each) { patch url, headers: auth_header(user) }

    include_examples "forbidden access"

  end

  context "DELETE /licenses/:id" do
    let!(:license) { create(:license) }
    let(:url) { "/admin/v1/licenses/#{license.id}"}

    before(:each) { delete url, headers: auth_header(user) }

    include_examples "forbidden access"

  end

end
