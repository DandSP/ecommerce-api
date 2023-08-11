require 'rails_helper'

RSpec.describe "Admin::V1::SystemRequirements without authentication", type: :request do

	context "GET /system_requirements" do
		let(:url) { "/admin/v1/system_requirements" }
		let(:system_requirement) { create_list(:system_requirement, 10) }

		before(:each) { get url }

		include_examples "unauthenticated access"
		
	end

	context "POST /system_requirements" do
		let(:url) { "/admin/v1/system_requirements" }
		let(:system_requirement_params) { { system_requirement: attributes_for(:system_requirement) }.to_json }

		before(:each) { post url }

		include_examples "unauthenticated access"

	end

	context "PATCH /system_requirements/:id" do
		let(:system_requirement) { create(:system_requirement) }
		let(:url) { "/admin/v1/system_requirements/#{system_requirement.id}" }

		before(:each) { patch url }

		include_examples "unauthenticated access"

	end

	context "DELETE /system_requirements/:id" do
		let(:system_requirement) { create(:system_requirement) }
		let(:url) { "/admin/v1/system_requirements/#{system_requirement.id}" }

		before(:each) { delete url }

		include_examples "unauthenticated access"

	end

end