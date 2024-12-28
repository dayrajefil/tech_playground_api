# frozen_string_literal: true

# spec/factories/organizacoes.rb
FactoryBot.define do
  factory :organizacao do
    trait :valid do
      n0_empresa { 'Empresa X' }
      n1_diretoria { 'Diretoria Y' }
      n2_gerencia { 'Gerência Z' }
      n3_coordenacao { 'Coordenação A' }
      n4_area { 'Área B' }
    end

    trait :invalid do
      n0_empresa { nil }
      n1_diretoria { nil }
      n2_gerencia { nil }
      n3_coordenacao { nil }
      n4_area { nil }
    end
  end
end
