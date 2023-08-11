require 'rails_helper'

RSpec.describe "Admin::V1::SystemRequirements as :admin", type: :request do
	let(:user) { create(:user) }

	context "GET /system_requirements" do
		let(:url) { "/admin/v1/system_requirements" }
		let!(:system_requirement) { create_list(:system_requirement, 10)}

		context "without params" do

			it 'returns 10 system_requirements' do
				get url, headers: auth_header(user)
				expect(body_json['system_requirements']).to contain_exactly *system_requirement.as_json(only: %i(id name operational_system storage processor memory video_board))
			end

			it 'returns success status' do
				get url, headers: auth_header(user)
				expect(response).to have_http_status(:ok)
			end

		end

	end

	context "POST /system_requirements" do
		let(:url) { "/admin/v1/system_requirements" }
		
		context "with valid params" do
			let(:system_requirement_params) { {system_requirement: attributes_for(:system_requirement)}.to_json}

			it 'adds a new system_requirement' do
				expect do
					post url, headers: auth_header(user), params: system_requirement_params
				end.to change(SystemRequirement, :count).by(1)
			end

			it 'returns last added system_requirement' do
				post url, headers: auth_header(user), params: system_requirement_params
				last_system_requirement = SystemRequirement.last.as_json(only: %i(id name operational_system storage processor memory video_board))
				expect(body_json['system_requirement']).to eq last_system_requirement
			end

			it 'returns success status' do
				post url, headers: auth_header(user), params: system_requirement_params
				expect(response).to have_http_status(:ok)
			end

		end

		context "with invalid params" do
			let(:system_requirement_invalid_params) { {system_requirement: attributes_for(:system_requirement, name: nil)}.to_json}

			it 'does not add a new system_requirement' do
				expect do
					post url, headers: auth_header(user), params: system_requirement_invalid_params
				end.to_not change(SystemRequirement, :count)
			end

			it 'returns unprocessable_entity status' do
				post url, headers: auth_header(user), params: system_requirement_invalid_params
				expect(response).to have_http_status(:unprocessable_entity)
			end

			it 'returns error messages' do
				post url, headers: auth_header(user), params: system_requirement_invalid_params
				expect(body_json['errors']['fields']).to have_key('name')
			end

		end

	end

	context "PATCH /system_requirements/:id" do
		let(:system_requirement) { create(:system_requirement) }
		let(:url) { "/admin/v1/system_requirements/#{system_requirement.id}"}

		context "with valid params" do
			let(:new_name) { 'Ex1' }
			let(:system_requirement_params) { {system_requirement: attributes_for(:system_requirement, name: new_name)}.to_json}

			it 'updates system_requirements' do
				patch url, headers: auth_header(user), params: system_requirement_params
				system_requirement.reload
				expect(system_requirement.name).to eq new_name
			end

			it 'returns success status' do
				patch url, headers: auth_header(user), params: system_requirement_params
				expect(response).to have_http_status(:ok)
			end

			it 'returns updated coupon' do
				patch url, headers: auth_header(user), params: system_requirement_params
				system_requirement.reload
				updated_system_requirement = SystemRequirement.as_json(only: %i(id name operational_system storage processor memory video_board))
			end

		end

		context "with invalid params" do 
			let(:system_requirement_invalid_params) { {system_requirement: attributes_for(:system_requirement, name: nil)}.to_json }

			it 'does not update the system_requirements' do
				old_name = system_requirement.name
				patch url, headers: auth_header(user), params: system_requirement_invalid_params
				system_requirement.reload
				expect(system_requirement.name).to eq old_name
			end

			it 'returns unprocessable_entity status' do
				patch url, headers: auth_header(user), params: system_requirement_invalid_params
				expect(response).to have_http_status(:unprocessable_entity)
			end
			
			it 'returns error messages' do
				patch url, headers: auth_header(user), params: system_requirement_invalid_params
				expect(body_json['errors']['fields']).to have_key('name')
			end

		end

	end

	context "DELETE /system_requirements/:id" do
		let!(:system_requirement) { create(:system_requirement) }
		let(:url) { "/admin/v1/system_requirements/#{system_requirement.id}" }

		it 'removes a system_requirement' do
			expect do
				delete url, headers: auth_header(user)
			end.to change(SystemRequirement, :count).by(-1)
		end

		it 'returns no_content status' do
			delete url, headers: auth_header(user)
			expect(response).to have_http_status(:no_content)
		end

		it 'does not return anybody content' do
			delete url, headers: auth_header(user)
			expect(body_json).to_not be_present
		end

	end

end
