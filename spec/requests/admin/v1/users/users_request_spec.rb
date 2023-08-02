# require 'rails_helper'

# RSpec.describe "Admin::V1::Users as :admin", type: :request do
# 	let(:user) { create(:user) }

# 	context "GET /users" do
# 		let(:url) { "/admin/v1/users" }
# 		let(:users) { create_list(:user, 10) }
		
# 		context "without any params" do

# 			it 'returns 10 users' do
# 				get url, headers: auth_header(user)
# 				expect(body_json['users']).to contain_exactly *users.as_json(only: %i(id name))
# 			end

# 			it 'returns success status' do
# 				get url, headers: auth_header(user)
# 				expect(response).to have_http_status(:ok)
# 			end

# 		end

# 	end

# 	context "POST /users" do
# 		let(:url) { "/admin/v1/users" }

# 		context "with valid params" do
# 			let(:user_params) { {user: attributes_for(:user)}.to_json }
			
# 			it 'returns success status' do
# 				post url, headers: auth_header(user), params: user_params
# 				expect(response).to have_http_status(:ok)
# 			end

# 			it 'adds a new user' do
# 				expect do
# 					post url, headers: auth_header(user), params: user_params
# 				end.to change(User, :count).by(1)
# 			end

# 			it 'returns last user' do
# 				post url, headers: auth_header(user), params: user_params
# 				last_user = User.last.as_json(only: %i(id name))
# 				expect(body_json['user']).to eq last_user
# 			end

# 		end

# 		context "with invalid params" do 
# 			let(:user_invalid_params) { {user: attributes_for(:user, name: nil)}.to_json }

# 			it 'does not add a new user' do
# 				expect do
# 					post url, headers: auth_header(user), params: user_invalid_params
# 				end.to_not change(User, :count)
# 			end	

# 			it 'returns unprocessable_entity status' do
# 				post url, headers: auth_header(user), params: user_invalid_params
# 				expect(response).to have_http_status(:unprocessable_entity)
# 			end

# 		end
# 	end

# end
