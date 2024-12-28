FactoryBot.define do
  factory :csv_row, class: CSV::Row do
    transient do
      valid_data { true }
    end

    sequence(:unique_id) { |n| n }

    initialize_with do
      new(
        [
          'nome', 'email', 'email_corporativo', 'area', 'cargo', 'funcao', 'localidade', 'tempo_de_empresa',
          'genero', 'geracao', 'n0_empresa', 'n1_diretoria', 'n2_gerencia', 'n3_coordenacao', 'n4_area',
          'Data da Resposta', 'Interesse no Cargo', 'Comentários - Interesse no Cargo', 'Contribuição',
          'Comentários - Contribuição', 'Aprendizado e Desenvolvimento', 'Comentários - Aprendizado e Desenvolvimento',
          'Feedback', 'Comentários - Feedback', 'Interação com Gestor', 'Comentários - Interação com Gestor',
          'Clareza sobre Possibilidades de Carreira', 'Comentários - Clareza sobre Possibilidades de Carreira',
          'Expectativa de Permanência', 'Comentários - Expectativa de Permanência', 'eNPS', '[Aberta] eNPS'
        ],
        valid_data ? 
        [
          "Nova Linha", "nova.linha#{unique_id}@email.com", "nova.linha#{unique_id}@empresa.com", 'financeiro',
          'analista', 'profissional', 'São Paulo', 'entre 1 e 2 anos', 'feminino', 'geração y', 'empresa',
          'diretoria', 'gerência', 'coordenação', 'área', '15/12/2023',
          '7', 'Comentário Interesse',
          '8', 'Comentário Contribuição',
          '6', 'Comentário Aprendizado',
          '9', 'Comentário Feedback',
          '8', 'Comentário Interação',
          '7', 'Comentário Clareza',
          '9', 'Comentário Expectativa',
          '8', 'Comentário eNPS'
        ] : 
        [
          nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
          nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
        ]
      )
    end

    trait :invalid do
      valid_data { false }
    end
  end
end
