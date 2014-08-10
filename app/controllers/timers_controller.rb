class TimersController < ApplicationController

    def create()
        Timer.create(params.require(:timer).permit(:expires_at, :numbers, :user_id))
        render :plain => "Created"
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
                    self.destroy2(user['user_id'])
                end
            end
        end
        render :plain => "Updated"
    end

    def show()
        user = Timer.find_by(user_id: params[:user_id])
        render :plain => user
    end

    def destroy()
        user = Timer.find_by_user_id params[:id]
        user.destroy()
        render :plain => "Destroyed"
    end


    def destroy2(user_id)
        user = Timer.find_by(user_id: user_id)
        user.destroy()
    end
end


