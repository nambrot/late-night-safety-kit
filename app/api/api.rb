require 'httparty'

class Api

    def crimes()
        source = "https://data.cityofboston.gov/resource/7cdf-6fgx.json"
        resp = Net::HTTP.get_response(URI.parse(source))
        data = resp.body
        crimes = Array.new
        crime = Struct.new(:latitude, :longitude, :incident, :dayofweek, :time, :day)
        result = JSON.parse(data).each do |item|
            crimes.push(crime.new(item['location']['latitude'], item['location']['longitude'], item['incident_type_description'], item['day_week'], item['fromdate'].split("T")[1], item["fromdate"].split("T")[0]))
        end
        return crimes
    end

    def police()
        source = "https://data.cityofboston.gov/resource/23yb-cufe.json"
        resp = Net::HTTP.get_response(URI.parse(source))
        data = resp.body
        police_stations = Array.new
        station = Struc.new(:latitude, :longitude, :address)
        result = JSON.parse(data).each do |item|
            police_stations.push(station.new(item['location']['latitude'], item['location']['longitude'], item['human_address']['address']))
        end
        return police_stations
    end

end
