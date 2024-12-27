# frozen_string_literal: true

# Enum que representa as funções dentro da empresa para a classe `Pessoa`.
#
# A classe `Funcao` define diferentes funções de uma pessoa dentro da organização,
# cada uma com um valor inteiro associado.
#
class Funcao < EnumMethods
  associate_values  manager: 0,
                    professional: 1
end
