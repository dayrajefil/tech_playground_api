# frozen_string_literal: true

# spec/controllers/api/v1/csv_imports_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::CsvImportsController, type: :controller do
  describe 'POST #create' do
    context 'when the file is not sent' do
      it 'returns error with appropriate message' do
        post :create, params: {}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['error']).to eq(I18n.t('messages.file_not_sent'))
      end
    end

    context 'when the CSV file is sent correctly' do
      let(:valid_file) { fixture_file_upload('valid_feedback.csv', 'text/csv') }

      it 'does the import successfully and returns the success message' do
        post :create, params: { file: valid_file }

        expect(response).to have_http_status(:ok)

        errors = response.parsed_body['errors']
        expect(errors).to be_nil

        expect(response.parsed_body['message']).to eq(I18n.t('messages.import_success'))
      end
    end

    context 'when the CSV file contains errors' do
      let(:invalid_file) { fixture_file_upload('invalid_feedback.csv', 'text/csv') }
      let(:expected_errors) do
        [
          { 'pessoa' => {
            'cargo' => { 'value' => nil, 'messages' => ['não pode ficar em branco'] },
            'funcao' => { 'value' => nil, 'messages' => ['não pode ficar em branco'] }
          } },
          { 'pessoa' => {
            'area' => { 'value' => nil, 'messages' => ['não pode ficar em branco'] },
            'localidade' => { 'value' => nil, 'messages' => ['não pode ficar em branco'] }
          } },
          { 'pessoa' => {
            'cargo' => { 'value' => nil, 'messages' => ['não pode ficar em branco'] },
            'funcao' => { 'value' => nil, 'messages' => ['não pode ficar em branco'] }
          } },
          { 'pessoa' => {
            'funcao' => { 'value' => nil, 'messages' => ['não pode ficar em branco'] },
            'localidade' => { 'value' => nil, 'messages' => ['não pode ficar em branco'] }
          } }
        ]
      end

      it 'returns error with import error messages' do
        post :create, params: { file: invalid_file }

        expect(response).to have_http_status(:unprocessable_entity)

        errors = response.parsed_body['errors']

        expect(errors.count).to eq(4)
        expect(errors).to match_array(expected_errors)
      end
    end
  end
end
