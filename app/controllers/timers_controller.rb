class TimersController < ApplicationController

    def create()
        Timer.create(params[:timer])
        render :plain => "OK"
    end

   def index()
        users = Timer.all
        for user in users
            if DateTime.now.to_i() > user[:expires_at].to_i()
                api = Api.new
                JSON.parse(user[:numbers]).each do |contact|
                    if contact['number']
                        api.sendtext(contact['number'], "Help I'm in trouble!")
                    elsif contact['email']
                        api.sendemail(contact['email'], "help", "Help I'm in trouble!")
                    end
                end
            end
        end
        render :plain => "OK"
    end

    def show()
        user = Timer.find_by(user_id: params[:user_id])
        render :plain => user
    end

    def destroy()
        user = Timer.find_by(user_id: params[:user_id])
        user.destroy()
        render :plain => "OK"
    end
end
