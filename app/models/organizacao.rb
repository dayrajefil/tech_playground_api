# frozen_string_literal: true

# Modelo que representa a organização de um colaborador, com informações sobre
# empresa, diretoria, gerência e área. Associa-se à classe Pessoa e valida a presença
# dos dados organizacionais.
#
class Organizacao < ApplicationRecord
  self.table_name = 'organizacoes'

  # belongs_to associations
  belongs_to :pessoa

  # validates presence
  validates :n0_empresa, :n1_diretoria, :n2_gerencia, :n3_coordenacao, :n4_area, presence: true
end
