# spec/factories/retornos.rb
FactoryBot.define do
  factory :retorno do
    trait :valid do
      data_da_resposta { Time.zone.today }
      interesse_no_cargo { 7 }
      comentario_interesse_no_cargo { 'Comentario interesse no cargo' }
      contribuicao { 6 }
      comentario_contribuicao { 'Comentario contribuicao' }
      aprendizado_e_desenvolvimento { 8 }
      comentarios_aprendizado_e_desenvolvimento { '-' }
      feedback { 9 }
      comentario_feedback { 'Comentario feedback' }
      interacao_com_gestor { 7 }
      comentario_interacao_com_gestor { 'Comentario interacao com gestor' }
      clareza_sobre_possibilidades_de_carreira { 6 }
      comentario_clareza_sobre_possibilidades_de_carreira { '-' }
      expectativa_de_permanencia { 5 }
      comentario_expectativa_de_permanencia { 'Comentario expectativa de permanencia' }
      enps { 8 }
      comentario_enps { 'Comentario enps' }

      association :pessoa, :valid
    end

    trait :invalid do
      data_da_resposta { Time.zone.today }
      interesse_no_cargo { 0 }
      comentario_interesse_no_cargo { nil }
      contribuicao { nil }
      comentario_contribuicao { nil }
      aprendizado_e_desenvolvimento { nil }
      comentarios_aprendizado_e_desenvolvimento { nil }
      feedback { nil }
      comentario_feedback { nil }
      interacao_com_gestor { nil }
      comentario_interacao_com_gestor { nil }
      clareza_sobre_possibilidades_de_carreira { nil }
      comentario_clareza_sobre_possibilidades_de_carreira { nil }
      expectativa_de_permanencia { nil }
      comentario_expectativa_de_permanencia { nil }
      enps { nil }
      comentario_enps { nil }

      association :pessoa, :invalid
    end
  end
end
