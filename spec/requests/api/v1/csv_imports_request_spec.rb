require 'rails_helper'

RSpec.describe 'API V1 CsvImports', type: :request do
  describe 'POST /api/v1/importar_dados' do
    let(:csv_file) { fixture_file_upload('valid_feedback.csv', 'text/csv') }

    it 'successfully import data' do
      post api_v1_importar_dados_path, params: { file: csv_file }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Importação bem-sucedida!')
    end

    it 'returns an error when the file is not sent' do
      post api_v1_importar_dados_path

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to eq('Nenhum arquivo enviado')
    end

    it 'returns error when file is not CSV' do
      invalid_file = fixture_file_upload('test_data.txt', 'text/txt')

      post api_v1_importar_dados_path, params: { file: invalid_file }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to eq('Formato de arquivo inválido. Por favor, envie um arquivo CSV.')
    end
  end
end
