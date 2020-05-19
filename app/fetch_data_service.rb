# frozen_string_literal: true

require "httparty"

# Fetch COVID-19 data from VOST's endpoints
class FetchDataService
  VOST_COVID_ENDPOINT = "https://covid19-api.vost.pt/Requests/get_entry".freeze

  def initialize; end

  def call
    today = Date.today.strftime("%d-%m-%Y")

    url = "#{VOST_COVID_ENDPOINT}/#{today}"
    response = HTTParty.get(url)

    return if response.code != 200

    {
      date: json_value(response, "data"),
      confirmed: json_value(response, "confirmados"),
      confirmed_new: json_value(response, "confirmados_novos"),
      deaths: json_value(response, "obitos"),
      interned_icu: json_value(response, "internados_uci"),
      recovered: json_value(response, "recuperados")
    }
  end

  private

  def json_value(data, key)
    data[key].values.first
  end
end
