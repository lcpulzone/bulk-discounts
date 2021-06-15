require 'rails_helper'

RSpec.describe DateService do
  it 'can request name and date of upcoming holidays from Nager.Date API' do

    mock_response = [{
      :date=>"2021-07-05",
      :localName=>"Independence Day",
      :name=>"Independence Day",
      :countryCode=>"US",
      :fixed=>false,
      :global=>true,
      :counties=>"null",
      :launchYear=>"null",
      :type=>"Public"
    },
    {
      :date=>"2021-09-06",
      :localName=>"Labor Day",
      :name=>"Labour Day",
      :countryCode=>"US",
      :fixed=>false,
      :global=>true,
      :counties=>nil,
      :launchYear=>nil,
      :type=>"Public"
    },
    {
      :date=>"2021-11-11",
      :localName=>"Veterans Day",
      :name=>"Veterans Day",
      :countryCode=>"US",
      :fixed=>false,
      :global=>true,
      :counties=>nil,
      :launchYear=>nil,
      :type=>"Public"
  }]

    allow(Faraday).to receive(:get).and_return(Faraday::Response.new)
    allow(JSON).to receive(:parse).and_return(mock_response)

    json = DateService.next_three_holidays

    expect(json).to be_a(Array)
    expect(json[0]).to have_key(:name)
    expect(json[0]).to have_key(:date)
    expect(json[0]).to have_key(:localName)
  end
end
