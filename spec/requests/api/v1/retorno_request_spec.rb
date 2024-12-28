require 'rails_helper'

RSpec.describe 'API V1 Retornos', type: :request do
  let!(:retornos) { create_list(:retorno, 15, :valid) }

  describe 'GET /api/v1/retornos' do
    it 'returns all feedbacks' do
      get api_v1_retornos_path

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)['collection']).to be_an(Array)
      expect(JSON.parse(response.body)['collection'].count).to eq 10
    end
  end

  describe 'GET /api/v1/retornos/:id' do
    it 'returns the feedback by ID' do
      get api_v1_retorno_path(retornos[0].id)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(retornos[0].id)
    end

    it 'returns an error when the feedback is not found' do
      get api_v1_retorno_path(id: 0)

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Feedback não encontrado.')
    end
  end

  describe 'POST /api/v1/retornos' do
    let(:build_retorno) { build(:retorno, :valid) }
    let(:pessoa_attributes) { build_retorno.pessoa.attributes }
    let!(:valid_attributes) { build_retorno.attributes }

    it 'create a new feedback' do
      expect {
        post api_v1_retornos_path, params: { retorno: valid_attributes.merge(pessoa_attributes: pessoa_attributes) }
      }.to change(Retorno, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['data_da_resposta'].to_date).to eq(build_retorno[:data_da_resposta])
    end

    it 'returns an error when trying to create a fedback with invalid data' do
      invalid_attributes = { data_da_resposta: nil }

      post api_v1_retornos_path, params: { retorno: invalid_attributes }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['data_da_resposta']).to include('não pode ficar em branco')
    end
  end

  describe 'PUT /api/v1/retornos/:id' do
    let(:valid_attributes) { { interesse_no_cargo: 8 } }

    it 'updates an existing feedback' do
      put api_v1_retorno_path(retornos[0].id), params: { retorno: valid_attributes }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['interesse_no_cargo']).to eq(8)
    end

    it 'returns error when trying to update with invalid data' do
      invalid_attributes = { interesse_no_cargo: nil }

      put api_v1_retorno_path(retornos[0].id), params: { retorno: invalid_attributes }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['interesse_no_cargo']).to include('não pode ficar em branco')
    end
  end

  describe 'DELETE /api/v1/retornos/:id' do
    it 'delete an existing feedback' do
      expect {
        delete api_v1_retorno_path(retornos[0].id)
      }.to change(Retorno, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Feedback deletado com sucesso.')
    end
  end
end
