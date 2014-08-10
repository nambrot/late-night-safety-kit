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

    #harcode a bunch of cab numbers and
    def cab_numbers()
        numbers = Array.new
        number = Struct.new(:company, :number)
        numbers.push(number.new("Metro Cab", "617-782-5500"))
        numbers.push(number.new("Boston Cab Association", "617-536-3200"))
        numbers.push(number.new("ITOA Cab Associates", "617-825-4000"))
        numbers.push(number.new("617TaxiCab", "617-829-4222"))
        return numbers
    end

    #send text from twilio
    def sendtext(number, message)
        fromnum =  "+16174019301"
        twilio_sid = "ACee7b5e78e45c9f9f4197f3560eead6cb"
        twilio_token = "d9fb0d0cf2185ff5c4372e150885d471"
        twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
        twilio_client.account.sms.messages.create(
            :from => fromnum,
            :to => number,
            :body => message
        )
    end

    #retrieve response from twilio
    def receivetext(from, body)
        message = Struct.new(:from, :msg)
        return JSON.parse(from, body)
    end

    #sends emails using sendgrid
    def sendemail(email, subject, message)
        source = "https://api.sendgrid.com/api/mail.send.json"
        HTTParty.post(
            source,
            body: {
                api_user: 'garidor',
                to: email,
                from: "garidor@gmail.com",
                subject: subject,
                text: message,
                api_key: 'password1!'
            }
        );
    end
end
