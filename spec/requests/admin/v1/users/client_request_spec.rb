require 'rails_helper'

RSpec.describe "Admin::V1::Users as :client", type: :request do
	let!(:client_user) { create(:user, profile: :client) }

  context "GET /users" do	
   	let(:url) { "/admin/v1/users" }
		let(:user) { create_list(:user, 10)}
			
		before(:each) { get url, headers: auth_header(client_user) }

		include_examples "forbidden access"

  end

	context "POST /users" do
		let(:url) { "/admin/v1/users" }
		let(:user_params) { {user: attributes_for(:user)}.to_json }

		before(:each) { post url, headers: auth_header(client_user), params: user_params }
			
		include_examples "forbidden access"
			
	end

	context "PATCH /users/:id" do
		let(:login_user) { create(:user) }
		let(:url) { "/admin/v1/users/#{login_user.id}" }
			
		before(:each) { patch url, headers: auth_header(client_user)}

		include_examples "forbidden access"

	end

	context "DELETE /users/:id" do
		let!(:delete_user) { create(:user) }
		let(:url) { "/admin/v1/users/#{delete_user.id}"}

		before(:each) { delete url, headers: auth_header(client_user) }

		include_examples "forbidden access"

	end

end