class ExchangesController < ApplicationController
  def index
  end

  def convert
    # value = params
    value = ExchangeService.new(params[:source_currency], params[:target_currency], params[:amount]).perform
    render json: {"value": value}, status: 200
  end
end
