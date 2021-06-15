class DateService
  def self.next_three_holidays
    response = Faraday.get 'https://date.nager.at/api/v2/NextPublicHolidays/us'
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[0..2]
  end
end
