# frozen_string_literal: true

module Api
  module V1 # rubocop:disable Style/Documentation
    # Controller responsável por gerenciar a importação de arquivos CSV.
    #
    # Este controlador lida com o processo de importação de dados de feedback de funcionários a partir de arquivos CSV.
    # Através do método `create`, ele recebe um arquivo, realiza a importação utilizando o serviço `ImportCsvService`
    # e retorna uma resposta JSON com sucesso ou erros.
    #
    # Exemplo de resposta de sucesso:
    #   {
    #     "message": "Importação bem-sucedida!"
    #   }
    #
    # Exemplo de resposta de erro:
    #   {
    #     "errors": [
    #       {
    #           "pessoa": {
    #               "email": {
    #                   "value": "demo001@pinpeople.com.br",
    #                   "messages": [
    #                       "já está em uso"
    #                   ]
    #               },
    #               "email_corporativo": {
    #                   "value": "demo001@pinpeople.com.br",
    #                   "messages": [
    #                       "já está em uso"
    #                   ]
    #               }
    #           }
    #       }
    #   ]
    # }
    #
    class CsvImportsController < ApplicationController
      def create
        file = params[:file]

        return render_file_not_sent if file.nil?

        service = ImportCsvService.new(file)
        service.import

        render_import_result(service)
      end

      private

      def render_file_not_sent
        render json: { error: I18n.t('messages.file_not_sent') }, status: :unprocessable_entity
      end

      def render_import_result(service)
        if service.errors.empty?
          render json: { message: I18n.t('messages.import_success') }, status: :ok
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
