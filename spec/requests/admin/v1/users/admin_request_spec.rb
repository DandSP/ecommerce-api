require 'rails_helper'

RSpec.describe "Admin::V1::Users as :admin", type: :request do
	let!(:user) { create(:user) }

	context "GET /users" do
		let(:url) { "/admin/v1/users" }
		let!(:users) { create_list(:user, 10) }
		
		context "without any params" do

			it 'returns 10 users' do
				get url, headers: auth_header(user)
				expect(body_json['users'].count).to eq 11
			end

			it 'returns success status' do
				get url, headers: auth_header(user)
				expect(response).to have_http_status(:ok)
			end

		end

	end

	context "POST /users" do
		let(:url) { "/admin/v1/users" }

		context "with valid params" do
			let(:user_params) { {user: attributes_for(:user)}.to_json }
			
			it 'returns success status' do
				post url, headers: auth_header(user), params: user_params
				expect(response).to have_http_status(:ok)
			end

			it 'adds a new user' do
				expect do
					post url, headers: auth_header(user), params: user_params
				end.to change(User, :count).by(1)
			end

			it 'returns last user' do
				post url, headers: auth_header(user), params: user_params
				last_user = User.last.as_json(only: %i(id name email profile))
				expect(body_json['user']).to eq last_user
			end

		end

		context "with invalid params" do 
			let(:user_invalid_params) { {user: attributes_for(:user, name: nil)}.to_json }

			it 'does not add a new user' do
				expect do
					post url, headers: auth_header(user), params: user_invalid_params
				end.to_not change(User, :count)
			end	

			it 'returns unprocessable_entity status' do
				post url, headers: auth_header(user), params: user_invalid_params
				expect(response).to have_http_status(:unprocessable_entity)
			end

			it 'returns error messages' do
				post url, headers: auth_header(user), params: user_invalid_params
				expect(body_json['errors']['fields']).to have_key('name')
			end

		end

	end

	context "PATCH /users/:id" do
		let(:login_user) { create(:user) }
		let(:url) { "/admin/v1/users/#{login_user.id}" } 

		context "with valid params" do	
			let(:new_name) { 'Juca' }
			let(:user_params) { { user: { name: new_name } }.to_json }

			it 'updates username' do
				patch url, headers: auth_header(user), params: user_params
				login_user.reload
				expect(login_user.name).to eq new_name
			end

			it 'returns updated user' do
				patch url, headers: auth_header(user), params: user_params
				login_user.reload
				updated_user = login_user.as_json(only: %i(id name email profile))
				expect(body_json['user']).to eq updated_user
			end

			it 'returns success status' do
				patch url, headers: auth_header(user), params: user_params
				expect(response).to have_http_status(:ok)
			end

		end

		context "with invalid params" do
			let(:user_invalid_params) { {user: attributes_for(:user, name: nil)}.to_json }

			it 'does not udpate username' do
				old_name = login_user.name
				patch url, headers: auth_header(user), params: user_invalid_params
				login_user.reload
				expect(login_user.name).to eq old_name
			end

			it 'returns unprocessable_entity status' do
				patch url, headers: auth_header(user), params: user_invalid_params
				expect(response).to have_http_status(:unprocessable_entity)
			end

			it 'returns error messages' do
				patch url, headers: auth_header(user), params: user_invalid_params
				expect(body_json['errors']['fields']).to have_key('name')
			end

		end

	end

	context "DELETE /users/:id" do
		let!(:delete_user) { create(:user) }
		let(:url) { "/admin/v1/users/#{delete_user.id}"}

		it 'when deleting the user' do
			expect do
				delete url, headers: auth_header(user)
			end.to change(User, :count).by(-1)
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
