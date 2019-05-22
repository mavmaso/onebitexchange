require 'rest-client'
require 'json'

class ExchangeService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f
  end

  def perform
    begin
      if (@source_currency == 'BTC')
        getBTC
      end
      exchange_api_url = Rails.application.credentials[Rails.env.to_sym][:currency_api_url]
      exchange_api_key = Rails.application.credentials[Rails.env.to_sym][:currency_api_key]
      url = "#{exchange_api_url}?token=#{exchange_api_key}&currency=#{@source_currency}/#{@target_currency}"
      res = RestClient.get url
      value = JSON.parse(res.body)['currency'][0]['value'].to_f
      value * @amount
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  def getBTC
    crypto_api_url = Rails.application.credentials[Rails.env.to_sym][:currency_api_url]
    exchange_api_key = Rails.application.credentials[Rails.env.to_sym][:currency_api_key]
    url = "#{crypto_api_url}?token=#{exchange_api_key}&symbol=#{@source_currency}"
    puts url
    res = RestClient.get url
    # value = JSON.parse(res.body)['symbols'][0]['value'].to_f
    value = 1
    if @target_currency != 'USD'
      @source_currency = 'USD'
      perform
    end
  end
end