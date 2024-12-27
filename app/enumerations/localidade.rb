# frozen_string_literal: true

# Enum que representa as localidades de uma pessoa na organização para a classe `Pessoa`.
#
# A classe `Localidade` define diferentes localidades dentro do Brasil com valores inteiros associados.
# Essas localidades são utilizadas para categorizar as pessoas de acordo com sua cidade de residência ou
# onde estão localizadas na organização, como Brasília, Manaus, Porto Alegre, Recife e São Paulo.
#
class Localidade < EnumMethods
  associate_values  brasilia: 0,
                    manaus: 1,
                    porto_alegre: 2,
                    recife: 3,
                    sao_paulo: 4
end
