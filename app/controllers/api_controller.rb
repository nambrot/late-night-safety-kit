class ApiController < ApplicationController

    def show
        if params[:id] == "crimes"
            render :file => "api/crimes.json"
        elsif params[:id] == "police"
            render :json => Api.new.police
        elsif params[:id] == "mbtastops"
            render :json => Api.new.mbtastops(params[:lat], params[:lng])
        elsif params[:id] == "cabnumbers"
            render :json => Api.new.cab_numbers
        elsif params[:id] == "sendtext"
            render :plain => Api.new.sendtext(params[:to], params[:msg])
        elsif params[:id] == "receivetext"
            render :json => Api.new.receivetext(params['From'], params['Body']) #TODO: configure twilio to route here
        elsif params[:id] == "sendemail"
            render :plain => Api.new.sendemail(params[:to], params[:subject], params[:msg])
        end
    end
end
