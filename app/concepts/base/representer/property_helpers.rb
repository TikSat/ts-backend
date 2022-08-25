module Base::Representer::PropertyHelpers
  extend ActiveSupport::Concern

  ##
  # Хелперы для отображения
  #   Пример использования: `property ... getter: utc_datetime`
  ##

  # Отобразить дату время в UTC формате
  def utc_datetime(**)
    proc do |represented:, binding:, **|
      input = represented.send(binding.name)

      input.utc.strftime('%Y-%m-%dT%H:%M:%S%:z') if input.present?
    end
  end
end
