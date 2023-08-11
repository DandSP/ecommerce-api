require 'rails_helper'

RSpec.describe "Admin::V1::SystemRequirements as :client", type: :request do
  let(:user) { create(:user, profile: :client) }

	context "GET /system_requirements" do
		let(:url) { "/admin/v1/system_requirements" }
		let(:system_requirement) { create_list(:system_requirement, 10) }

		before(:each) { get url, headers: auth_header(user) }

		include_examples "forbidden access"

	end

	context "POST /system_requirements" do
		let(:url) { "/admin/v1/system_requirements" }
		let(:system_requirement_params) { { system_requirement: attributes_for(:system_requirement)}.to_json }

		before(:each) { post url, headers: auth_header(user), params: system_requirement_params }
		
		include_examples "forbidden access"

	end

	context "PATCH /system_requirements/:id" do
		let(:system_requirement) { create(:system_requirement) }
		let(:url) { "/admin/v1/system_requirements/#{system_requirement.id}" }

		before(:each) { patch url, headers: auth_header(user) }
		
		include_examples "forbidden access"
	end

	context "DELETE /system_requirements/:id" do
		let(:system_requirement) { create(:system_requirement) }
		let(:url) { "/admin/v1/system_requirements/#{system_requirement.id}" }

		before(:each) { delete url, headers: auth_header(user) }

		include_examples "forbidden access"

	end

end