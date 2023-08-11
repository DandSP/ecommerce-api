require 'rails_helper'

describe Admin::ModelLoadingService do
	context "when #call" do
		let!(:categories) { create_list(:category, 15) }

		context "with params" do
			let!(:search_categories) do
				categories = []
				15.times { |n| categories << create(:category, name: "Search #{n + 1}") }
				categories
			end

			let(:params) do
				{ search: { name: "Search" }, order: {name: :desc}, page: 2, length: 4 } 
			end

			it 'returns right :length following pagination' do
				service = described_class.new(Category.all, params)
				result = service.call
				expect(result.count).to eq 4
			end

			it 'returns records following search, order and pagination' do
				search_categories.sort! { |a, b| b[:name] <=> a[:name] }
				service = described_class.new(Category.all, params)
				result = service.call
				expected_categories = search_categories[4..7]
				expect(result).to contain_exactly *expected_categories
			end

		end

		context "without params" do  

			it 'returns default :length pagination' do
				service = described_class.new(Category.all, nil)
				result = service.call
				expect(result.count).to eq 10
			end

			it 'returns first 10 records' do
				service = described_class.new(Category.all, nil)
				result = service.call
				expected_categories = categories[0..9]
				expect(result).to contain_exactly *expected_categories
			end

		end
 
	end	
end