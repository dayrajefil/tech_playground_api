# spec/factories/pessoas.rb
FactoryBot.define do
  factory :pessoa do
    trait :valid do
      nome { "Teste" }
      sequence(:email) { |n| "teste#{n}@exemplo.com" }
      sequence(:email_corporativo) { |n| "teste.corp#{n}@exemplo.com" }
      area { Area::ADMINISTRATIVE }
      cargo { Cargo::ANALYST }
      funcao { Funcao::MANAGER }
      localidade { Localidade::SAO_PAULO }
      tempo_de_empresa { TempoDeEmpresa::BETWEEN_TWO_AND_FIVE }
      genero { Genero::MALE }
      geracao { Geracao::BABY_BOOMER }

      after(:create) do |pessoa|
        create(:organizacao, :valid, pessoa: pessoa)
      end
    end

    trait :invalid do
      nome { nil }
      email { "teste@exemplo.com" }
      email_corporativo { "teste.corp@exemplo.com" }
      area { Area::ADMINISTRATIVE }
      cargo { Cargo::ANALYST }
      funcao { Funcao::MANAGER }
      localidade { Localidade::SAO_PAULO }
      tempo_de_empresa { TempoDeEmpresa::BETWEEN_TWO_AND_FIVE }
      genero { Genero::MALE }
      geracao { Geracao::BABY_BOOMER }

      after(:create) do |pessoa|
        create(:organizacao, :invalid, pessoa: pessoa)
      end
    end
  end
end