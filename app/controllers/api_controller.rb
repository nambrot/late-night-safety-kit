class ApiController < ApplicationController

    def show
        if params[:id] == "crimes"
            render :json => Api.new.crimes
        elsif params[:id] == "police"
            render :json => Api.new.police
        end
    end
end
