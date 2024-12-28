# spec/controllers/api/v1/retornos_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::RetornosController, type: :controller do
  let(:retorno_invalid) { build(:retorno, :invalid) }

  describe 'GET #index' do
    it 'returns a paginated list of feedbacks' do
      retorno = create(:retorno, :valid)
      get :index, params: { page: 1 }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['collection'].length).to eq(1)
      expect(JSON.parse(response.body)['meta']).to have_key('current_page')
    end
  end

  describe 'GET #show' do
    it 'returns a specific feedback' do
      retorno = create(:retorno, :valid)
      get :show, params: { id: retorno.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(retorno.id)
    end

    it 'returns an error when feedback is not found' do
      get :show, params: { id: 999 }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq("Feedback não encontrado.")
    end
  end

  describe 'POST #create' do
    let(:pessoa_valid) { build(:pessoa, :valid) }
    let(:pessoa_invalid) { build(:pessoa, :valid) }

    let(:retorno_valid) { build(:retorno, :valid, pessoa: pessoa_valid) }
    let(:organizacao_valid) { build(:organizacao, :valid, pessoa: pessoa_valid) }

    let(:retorno_invalid) { build(:retorno, :invalid, pessoa: pessoa_invalid) }
    let(:organizacao_invalid) { build(:organizacao, :invalid, pessoa: pessoa_invalid) }

    context 'with valid attributes' do
      it 'creates a new feedback and returns status created' do
        post :create, params: { 
          retorno: retorno_valid.attributes.merge(
            pessoa_attributes: pessoa_valid.attributes.merge(
              organizacao_attributes: organizacao_valid.attributes
            )
          )
        }

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new feedback and returns errors' do
        post :create, params: { 
          retorno: retorno_invalid.attributes.merge(
            pessoa_attributes: pessoa_invalid.attributes.merge(
              organizacao_attributes: organizacao_invalid.attributes
            )
          )
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let!(:retorno) { create(:retorno, :valid) }

    context 'with valid attributes' do
      it 'updates the feedback' do
        put :update, params: { id: retorno.id, retorno: { data_da_resposta: "2024-12-28" } }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data_da_resposta']).to eq("2024-12-28")
      end
    end

    context 'with invalid attributes' do
      it 'does not update the feedback and returns errors' do
        put :update, params: { id: retorno.id, retorno: { interesse_no_cargo: 0 } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['interesse_no_cargo']).to include("deve estar entre 1 e 10")
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:retorno) { create(:retorno, :valid) }

    it 'deletes the feedback and associated person' do
      expect {
        delete :destroy, params: { id: retorno.id }
      }.to change(Retorno, :count).by(-1)
      .and change(Pessoa, :count).by(-1)
      .and change(Organizacao, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq("Feedback deletado com sucesso.")
    end

    it 'returns an error if deletion fails' do
      allow_any_instance_of(Retorno).to receive(:destroy).and_raise(StandardError.new("Deletion error"))
      delete :destroy, params: { id: retorno.id }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to eq("Erro ao deletar o feedback.")
    end
  end
end
