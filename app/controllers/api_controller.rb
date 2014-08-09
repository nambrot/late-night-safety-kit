class ApiController < ApplicationController

    def show
        if params[:id] == "boston_data"
            render :json => Api.new.boston_data
        end
    end
end
