class User::TradesController < User::ApplicationController
  before_action :set_trade_params, only: [:show, :edit]

  def index
    @trades = current_user.trades.all
  end

  def new
    @trade = Trade.new
  end

  def show; end

  def edit; end

  private

  def set_trade_params
    @trade = current_user.trades.find(params[:id])
  end

end