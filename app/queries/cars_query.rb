class CarsQuery
  def initialize(params, scope = Car.all)
    @params = params.respond_to?(:to_unsafe_h) ? params.to_unsafe_h.with_indifferent_access : params.with_indifferent_access
    @scope = scope
  end

  def call
    filter_by_make
    filter_by_model
    filter_by_color
    filter_by_price
    filter_by_year
    filter_by_mileage
    apply_sorting

    @scope
  end

  private

  def filter_by_make
    return if @params[:make].blank?
    @scope = @scope.where("make ILIKE ?", "%#{@params[:make]}%")
  end

  def filter_by_model
    return if @params[:model].blank?
    @scope = @scope.where("model ILIKE ?", "%#{@params[:model]}%")
  end

  def filter_by_color
    return if @params[:color].blank?
    @scope = @scope.where("color ILIKE ?", "%#{@params[:color]}%")
  end

  def filter_by_price
    @scope = @scope.where("price >= ?", @params[:min_price].to_f) if @params[:min_price].present?
    @scope = @scope.where("price <= ?", @params[:max_price].to_f) if @params[:max_price].present?
  end

  def filter_by_year
    @scope = @scope.where("year >= ?", @params[:year_from].to_i) if @params[:year_from].present?
    @scope = @scope.where("year <= ?", @params[:year_to].to_i) if @params[:year_to].present?
  end

  def filter_by_mileage
    @scope = @scope.where("odometer >= ?", @params[:min_mileage].to_i) if @params[:min_mileage].present?
    @scope = @scope.where("odometer <= ?", @params[:max_mileage].to_i) if @params[:max_mileage].present?
  end

  def apply_sorting
    sort_logic = {
      "price_asc"  => { price: :asc },
      "price_desc" => { price: :desc },
      "newest"     => { created_at: :desc }
    }

    order_params = sort_logic[@params[:sort]] || sort_logic["newest"]
    @scope = @scope.order(order_params)
  end
end
