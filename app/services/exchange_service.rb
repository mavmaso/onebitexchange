require 'rest-client'
require 'json'

class ExchangeService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f
    @crypto_api_url = Rails.application.credentials[Rails.env.to_sym][:crypto_api_url]
    @cripto_api_key = Rails.application.credentials[Rails.env.to_sym][:crypto_api_key]
    @exchange_api_key = Rails.application.credentials[Rails.env.to_sym][:currency_api_key]
    @exchange_api_url = Rails.application.credentials[Rails.env.to_sym][:currency_api_url]
  end



  def perform
    begin
      if (@source_currency == 'BTC')
        value = getBTC
        value * @amount
      else
        url = "#{@exchange_api_url}?token=#{@exchange_api_key}&currency=#{@source_currency}/#{@target_currency}"
        res = RestClient.get url
        value = JSON.parse(res.body)['currency'][0]['value'].to_f
        value * @amount
      end
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  def getBTC
    url = "#{@crypto_api_url}?api_key=#{@cripto_api_key}&fsym=#{@source_currency}&tsyms=#{@target_currency}"
    res = RestClient.get url
    # value = JSON.parse(res.body)[@target_currency].to_f
    value = 1
  end
end