# frozen_string_literal: true

# Enum que representa o tempo de empresa de uma pessoa na organização para a classe `Pessoa`.
#
# A classe `TempoDeEmpresa` define diferentes intervalos de tempo em que uma pessoa pode estar
# trabalhando na organização, com valores inteiros associados. Esses intervalos são usados para
# categorizar os funcionários de acordo com o tempo de serviço, como menos de um ano, entre um e
# dois anos, entre dois e cinco anos, e mais de cinco anos.
#
class TempoDeEmpresa < EnumMethods
  associate_values  less_than_one: 0,
                    between_one_and_two: 1,
                    between_two_and_five: 2,
                    more_than_five: 3
end
