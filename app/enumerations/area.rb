# frozen_string_literal: true

# Enum que representa as áreas de atuação dentro da empresa para a classe `Pessoa`.
#
# A classe `Area` define diferentes áreas de atuação de uma pessoa dentro da organização,
# cada uma com um valor inteiro associado.
#
class Area < EnumMethods
  associate_values  administrative: 0,
                    commercial: 1,
                    financial: 2,
                    human_resources: 3,
                    technology: 4
end
