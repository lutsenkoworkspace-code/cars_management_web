module SavedSearchesHelper
  def format_query_params(query_params)
    params = query_params.is_a?(String) ? JSON.parse(query_params) : query_params

    return t("saved_searches.any_params") if params.blank? || params.values.all?(&:blank?)

    parts = []

    make_model = [ params["make"], params["model"] ].select(&:present?).join(" ")
    parts << make_model if make_model.present?

    if params["min_price"].present? || params["max_price"].present?
      price = "#{t('activerecord.attributes.car.price')}: "
      price += "#{t('saved_searches.params.from')} $#{params['min_price']} " if params["min_price"].present?
      price += "#{t('saved_searches.params.to')} $#{params['max_price']}" if params["max_price"].present?
      parts << price
    end

    if params["min_mileage"].present? || params["max_mileage"].present?
      mileage = "#{t('activerecord.attributes.car.mileage')}: #{params['min_mileage'].presence || 0} - #{params['max_mileage'].presence || '∞'} #{t('saved_searches.params.km')}"
      parts << mileage
    end

    parts.join(" • ")
  rescue JSON::ParserError
    "Error parsing data"
  end
end
