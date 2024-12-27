# frozen_string_literal: true

module Api
  module V1
    # Controlador responsável pelas operações CRUD de retornos de feedback.
    # Este controlador permite criar, atualizar, exibir e deletar feedbacks,
    # bem como gerenciar as informações relacionadas à pessoa e organização associadas.
    #
    class RetornosController < ApplicationController
      before_action :set_retorno, only: %i[show update destroy]

      # GET /retornos
      def index
        @retornos = Retorno.includes(pessoa: :organizacao).page(params[:page])
        render json: { collection: @retornos, meta: pagination_meta(@retornos) },
include: { pessoa: { include: :organizacao } }
      end

      # GET /retornos/:id
      def show
        render json: @retorno, include: { pessoa: { include: :organizacao } }
      end

      # POST /retornos
      def create
        @retorno = Retorno.new(retorno_params)

        if @retorno.save
          render json: @retorno, status: :created, include: { pessoa: { include: :organizacao } }
        else
          render json: @retorno.errors, status: :unprocessable_entity
        end
      end

      # PUT /retornos/:id
      def update
        if @retorno.update(retorno_params)
          render json: @retorno, include: { pessoa: { include: :organizacao } }
        else
          render json: @retorno.errors, status: :unprocessable_entity
        end
      end

      # DELETE /retornos/:id
      def destroy
        @retorno.pessoa.destroy
        render json: { message: I18n.t('controllers.api.v1.retornos.deleted') }, status: :ok
      rescue StandardError => e
        render json: { error: I18n.t('controllers.api.v1.retornos.deletion_error'), details: e.message },
                status: :unprocessable_entity
      end

      private

      def set_retorno
        @retorno = Retorno.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: I18n.t('controllers.api.v1.retornos.not_found', id: params[:id]) }, status: :not_found
      end

      def retorno_params
        params.require(:retorno).permit(
          :data_da_resposta, :interesse_no_cargo, :comentario_interesse_no_cargo, :contribuicao,
          :comentario_contribuicao, :aprendizado_e_desenvolvimento, :comentarios_aprendizado_e_desenvolvimento,
          :feedback, :comentario_feedback, :interacao_com_gestor, :comentario_interacao_com_gestor,
          :clareza_sobre_possibilidades_de_carreira, :comentario_clareza_sobre_possibilidades_de_carreira,
          :expectativa_de_permanencia, :comentario_expectativa_de_permanencia, :enps, :comentario_enps,
          pessoa_attributes: pessoa_params
        )
      end

      def pessoa_params
        [
          :id, :nome, :email, :email_corporativo, :area, :cargo, :funcao, :localidade, :tempo_de_empresa,
          :genero, :geracao, {
            organizacao_attributes: organizacao_params
          }
        ]
      end

      def organizacao_params
        %i[id n0_empresa n1_diretoria n2_gerencia n3_coordenacao n4_area]
      end
    end
  end
end
