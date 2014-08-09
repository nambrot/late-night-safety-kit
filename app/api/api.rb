require 'httparty'

class Api
    #get recent crime data
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

    #get the closest police stations
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

    #get the mbta stops by location
    def mbtastops(lat, lng)
        mbta_api_key ="wX9NwuHnZU2ToO7GmGR9uw"
        source = "http://realtime.mbta.com/developer/api/v2/stopsbylocation?api_key=" + mbta_api_key + "&lat=" + lat + "&lon=" + lng + "&format=json"
        resp = Net::HTTP.get_response(URI.parse(source))
        data = resp.body
        result = JSON.parse(data)
        stops = Array.new
        stop = Struct.new(:distance, :name, :latitude, :longitude)
        list_of_stops = result['stop']
        for item in list_of_stops
            stops.push(stop.new(item['distance'], item['stop_name'], item['stop_lat'], item['stop_lon']))
        end
        return stops
    end


end
