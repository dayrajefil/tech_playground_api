# frozen_string_literal: true

module Api
  module V1
    # Controller responsável por gerenciar a importação de arquivos CSV.
    #
    # Este controlador lida com o processo de importação de dados de feedback de funcionários a partir de arquivos CSV.
    # Através do método `create`, ele recebe um arquivo, realiza a importação utilizando o serviço `ImportCsvService`
    # e retorna uma resposta JSON com sucesso ou erros.
    #
    class CsvImportsController < ApplicationController
      def create
        file = params[:file]

        return render_file_not_sent if file.nil?
        return render_invalid_file_format unless csv_file?(file)

        service = ImportCsvService.new(file)
        service.import

        render_import_result(service)
      end

      private

      def csv_file?(file)
        file.content_type == 'text/csv'
      end

      def render_file_not_sent
        render json: { error: I18n.t('messages.file_not_sent') }, status: :unprocessable_entity
      end

      def render_invalid_file_format
        render json: { error: I18n.t('messages.invalid_file_format') }, status: :unprocessable_entity
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
