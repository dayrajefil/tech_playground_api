# frozen_string_literal: true

# Enum que representa as gerações de uma pessoa dentro da organização para a classe `Pessoa`.
#
# A classe `Geracao` define diferentes gerações de uma pessoa com valores inteiros associados.
# Essas gerações são utilizadas para categorizar as pessoas de acordo com seu grupo geracional,
# como Baby Boomer, Geração X, Geração Y e Geração Z.
#
class Geracao < EnumMethods
  associate_values  baby_boomer: 0,
                    x_generation: 1,
                    y_generation: 2,
                    z_generation: 2
end
