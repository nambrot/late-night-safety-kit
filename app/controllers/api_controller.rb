class ApiController < ApplicationController

    def show
        if params[:id] == "crimes"
            render :json => Api.new.crimes
        elsif params[:id] == "police"
            render :json => Api.new.police
        elsif params[:id] == "mbtastops"
            render :json => Api.new.mbtastops(params[:lat], params[:lng])
        end
    end
end
