# frozen_string_literal: true

# Classe base para os enums da aplicação, que estende a funcionalidade da gem EnumerateIt.
#
# A classe `EnumMethods` fornece métodos auxiliares para facilitar a manipulação e tradução de
# valores de enums. Ela utiliza a gem `EnumerateIt` para definir enums baseados em valores inteiros,
# e define um método adicional para obter o valor do enum a partir da tradução correspondente no arquivo
# de internacionalização (I18n).
#
class EnumMethods < EnumerateIt::Base
  def self.value_from_translation(translation)
    key = keys.find do |k|
      I18n.t("enumerations.#{name.demodulize.underscore}.#{k}").casecmp(translation).zero?
    end

    value_for(key.to_s.upcase) if key
  end
end
