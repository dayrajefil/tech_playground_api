# frozen_string_literal: true

# Modelo que representa o retorno de feedback de uma pessoa, contendo
# informações sobre interesse no cargo, contribuição, aprendizado, entre
# outros aspectos relacionados ao desempenho e expectativas. Valida a presença
# de diversos campos relacionados ao feedback.
#
class Retorno < ApplicationRecord
  # belongs_to associations
  belongs_to :pessoa

  # accepts_nested_attributes
  accepts_nested_attributes_for :pessoa, allow_destroy: true

  # validates presence
  validates :data_da_resposta, :interesse_no_cargo, :comentario_interesse_no_cargo, :contribuicao,
            :comentario_contribuicao, :aprendizado_e_desenvolvimento, :comentarios_aprendizado_e_desenvolvimento,
            :feedback, :comentario_feedback, :interacao_com_gestor, :comentario_interacao_com_gestor,
            :clareza_sobre_possibilidades_de_carreira, :comentario_clareza_sobre_possibilidades_de_carreira,
            :expectativa_de_permanencia, :comentario_expectativa_de_permanencia, :enps, :comentario_enps,
            presence: true

  validates :interesse_no_cargo, :contribuicao, :aprendizado_e_desenvolvimento, :feedback, :interacao_com_gestor,
            :clareza_sobre_possibilidades_de_carreira, :expectativa_de_permanencia, :enps,
            inclusion: { in: 1..10, message: I18n.t('errors.messages.range.between', min: 1, max: 10) }

end
