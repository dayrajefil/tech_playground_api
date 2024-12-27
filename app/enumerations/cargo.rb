# frozen_string_literal: true

# Enum que representa os cargos de uma pessoa dentro da organização para a classe `Pessoa`.
#
# A classe `Cargo` define diferentes cargos ou posições que uma pessoa pode ocupar dentro da empresa,
# cada um com um valor inteiro associado.
#
class Cargo < EnumMethods
  associate_values  intern: 0,
                    analyst: 1,
                    coordinator: 2,
                    manager: 3,
                    director: 4
end
