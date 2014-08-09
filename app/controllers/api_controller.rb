class ApiController < ApplicationController

    def show
        if params[:id] == "crimes"
            render :json => Api.new.crimes
        elsif params[:id] == "police"
            render :json => Api.new.police
        elsif params[:id] == "mbtastops"
            render :json => Api.new.mbtastops(params[:lat], params[:lng])
        elsif params[:id] == "cabnumbers"
            render :json => Api.new.cab_numbers
        end
    end
end
