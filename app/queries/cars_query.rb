class CarsQuery
  def initialize(params, scope = Car.all)
    @params = params
    @scope = scope
  end

  def call
    filter_by_make
    filter_by_model
    filter_by_price
    filter_by_color
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

  def filter_by_price
    @scope = @scope.where("price >= ?", @params[:min_price]) if @params[:min_price].present?
    @scope = @scope.where("price <= ?", @params[:max_price]) if @params[:max_price].present?
  end

  def filter_by_color
    return if @params[:color].blank?
    @scope = @scope.where("color ILIKE ?", "%#{@params[:color]}%")
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
