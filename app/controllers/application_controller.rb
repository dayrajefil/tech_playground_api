# frozen_string_literal: true

# Classe base para todos os controladores da API. Herda de ActionController::API,
# que é otimizado para aplicações somente API, sem a carga de funcionalidades desnecessárias
# como views ou helpers de HTML.
#
class ApplicationController < ActionController::API
  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end
end
