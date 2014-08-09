require 'httparty'

class Api
    mbta_api_key ="wX9NwuHnZU2ToO7GmGR9uw"
    def crimes()
        source = "https://data.cityofboston.gov/resource/7cdf-6fgx.json"
        resp = Net::HTTP.get_response(URI.parse(source))
        data = resp.body
        crimes = Array.new
        crime = Struct.new(:latitude, :longitude, :incident, :dayofweek, :time, :day)
        JSON.parse(data).each do |item|
            crimes.push(crime.new(item['location']['latitude'], item['location']['longitude'], item['incident_type_description'], item['day_week'], item['fromdate'].split("T")[1], item["fromdate"].split("T")[0]))
        end
        return crimes
    end

    def police()
        source = "https://data.cityofboston.gov/resource/23yb-cufe.json"
        resp = Net::HTTP.get_response(URI.parse(source))
        data = resp.body
        police_stations = Array.new
        station = Struct.new(:latitude, :longitude, :address)
        JSON.parse(data).each do |item|
            human_address = JSON.parse(item["location"]["human_address"])
            police_stations.push(station.new(item['location']['latitude'], item['location']['longitude'], human_address["address"]))
        end
        return police_stations
    end

    def mbta()
        url = "http://realtime.mbta.com/developer/api/v2/stopsbylocation?"
    end


end
