# frozen_string_literal: true

require "httparty"

# Fetch COVID-19 data from VOST's endpoints
class FetchDataService
  VOST_COVID_ENDPOINT = "https://covid19-api.vost.pt/Requests/get_entry".freeze

  def initialize; end

  def call
    yesterdays_response = data(Date.today.prev_day.strftime("%d-%m-%Y"))
    todays_response = data(Date.today.strftime("%d-%m-%Y"))

    {
      date: json_value(todays_response, "data"),
      confirmed: json_value(todays_response, "confirmados"),
      confirmed_new: json_value(todays_response, "confirmados_novos"),
      deaths: json_value(todays_response, "obitos"),
      deaths_new: json_value(todays_response, "obitos") - json_value(yesterdays_response, "obitos"),
      interned_icu: json_value(todays_response, "internados_uci"),
      recovered: json_value(todays_response, "recuperados")
    }
  end

  private

  def data(date)
    url = "#{VOST_COVID_ENDPOINT}/#{date}"
    response = HTTParty.get(url)

    return if response.code != 200

    response
  end

  def json_value(data, key)
    data[key].values.first
  end
end
