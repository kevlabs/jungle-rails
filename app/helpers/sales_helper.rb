module SalesHelper
  def active_sale
    Sale.active.first
  end

end