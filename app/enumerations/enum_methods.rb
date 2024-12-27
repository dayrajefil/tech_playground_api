class EnumMethods < EnumerateIt::Base
  def self.value_from_translation(translation)
    key = keys.find do |k|
      I18n.t("enumerations.#{name.demodulize.underscore}.#{k}").casecmp(translation).zero?
    end

    value_for(key.to_s.upcase) if key
  end
end
