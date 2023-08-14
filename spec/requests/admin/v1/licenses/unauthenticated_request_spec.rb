require 'rails_helper'

RSpec.describe "Admin::V1::Licenses without authentication", type: :request do

  context "GET /games/:game_id/licenses" do
    let(:url) { "/admin/v1/games/#{game_id}/licenses" }

  end

  context "POST /games/:game_id/licenses" do
    let(:url) { "/admin/v1/games/#{game_id}/licenses" }

  end

  context "GET /licenses/:id" do
    let!(:license) { create(:license) }
    let(:url) { "/admin/v1/licenses/#{license.id}"}
    
  end

  context "PATCH /licenses:id" do
    let!(:license) { create(:license) }
    let(:url) { "/admin/v1/licenses/#{license.id}"}

  end

  context "DELETE /licenses/:id" do
    let!(:license) { create(:license) }
    let(:url) { "/admin/v1/licenses/#{license.id}"}

  end

end
