# frozen_string_literal: true

# spec/controllers/application_controller_spec.rb
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#pagination_meta' do
    let(:valid_collection) do
      double(
        'Collection',
        current_page: 1,
        next_page: 2,
        prev_page: nil,
        total_pages: 3,
        total_count: 30
      )
    end

    let(:empty_collection) do
      double(
        'Collection',
        current_page: 1,
        next_page: nil,
        prev_page: nil,
        total_pages: 0,
        total_count: 0
      )
    end

    it 'returns the correct pagination metadata for a valid collection' do
      result = controller.pagination_meta(valid_collection)

      expect(result).to eq(
        { current_page: 1, next_page: 2, prev_page: nil, total_pages: 3, total_count: 30 }
      )
    end

    it 'returns correct pagination metadata for an empty collection' do
      result = controller.pagination_meta(empty_collection)

      expect(result).to eq(
        { current_page: 1, next_page: nil, prev_page: nil, total_pages: 0, total_count: 0 }
      )
    end

    it 'raises an error if the collection is nil' do
      expect(controller.pagination_meta(nil)).to be_nil
    end
  end
end
