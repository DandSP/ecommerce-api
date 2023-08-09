require 'rails_helper'

RSpec.describe "Admin::V1::Coupons without authentication", type: :request do

  context "GET /coupons" do
		let(:url) { "/admin/v1/coupons" }
		let(:coupon) { create_list(:coupon, 10) }

		before(:each) { get url }

		include_examples "unauthenticated access"

	end


	context "POST /coupons" do
		let(:url) { "/admin/v1/coupons" }
		let(:coupon) { create(:coupon) }

		before(:each) { post url }

		include_examples "unauthenticated access"

	end


	context "PATCH /coupons/:id" do
		let(:coupon) { create(:coupon) }
		let(:url) { "/admin/v1/coupons/#{coupon.id}" }

		before(:each) { patch url }

		include_examples "unauthenticated access"

	end


	context "DELETE /coupons/:id " do
		let(:coupon) { create(:coupon) }
		let(:url) { "/admin/v1/coupons/#{coupon.id}" }

		before(:each) { delete url }

		include_examples "unauthenticated access"
		
	end


end