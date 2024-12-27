# frozen_string_literal: true

# Enum que representa os gêneros de uma pessoa dentro da organização para a classe `Pessoa`.
#
# A classe `Genero` define diferentes gêneros para uma pessoa, com valores inteiros associados.
# Esses gêneros são utilizados para categorizar as pessoas de acordo com seu gênero, como "outro",
# "feminino" e "masculino".
#
class Genero < EnumMethods
  associate_values  other: 0,
                    female: 1,
                    male: 2
end
