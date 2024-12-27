# frozen_string_literal: true

# Modelo que representa uma pessoa com informações pessoais e profissionais.
# Associa-se a uma organização e aos retornos (feedback). Valida a presença de
# nome, email, email_corporativo, area, cargo, funcao, localidade, tempo_de_empresa, genero, geracao
# e unicidade dos campos email e email_corporativo.
#
class Pessoa < ApplicationRecord
  # has_one associations
  has_one :organizacao, dependent: :destroy
  has_one :retorno, dependent: :destroy

  # accepts_nested_attributes
  accepts_nested_attributes_for :organizacao, allow_destroy: true

  # enumerations
  has_enumeration_for :area
  has_enumeration_for :cargo
  has_enumeration_for :funcao
  has_enumeration_for :tempo_de_empresa
  has_enumeration_for :genero
  has_enumeration_for :geracao

  # validates presence
  validates :nome, :email, :email_corporativo, :area, :cargo, :funcao, :localidade, :tempo_de_empresa,
            :genero, :geracao, presence: true

  # validates uniqueness
  validates :email, :email_corporativo, uniqueness: true # rubocop:disable Rails/UniqueValidationWithoutIndex
end
