class Admin::SalesController < ApplicationController
  def index
    @sales = Sale.order(starts_on: :desc).all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      redirect_to [:admin, :sales], notice: 'Sale created!'
    else
      render :new
    end
  end

  def edit
    @sale = Sale.find params[:id]
  end

  def update
    @sale = Sale.find params[:id]
    if @sale.update sale_params
      redirect_to [:admin, :sales], notice: 'Sale updated!'
    else
      render :edit
    end
  end

  def destroy
    @sale = Sale.find params[:id]
    @sale.destroy
    redirect_to [:admin, :sales], notice: 'Sale deleted!'
  end

  private

  def sale_params
    params.require(:sale).permit(
      :name,
      :starts_on,
      :ends_on,
      :percent_off
    )
  end

end
