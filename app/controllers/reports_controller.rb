class ReportsController < ApplicationController
    def create()
        r = Report.create(params.require(:report).permit(:image, :latitude, :description, :longitude))
        api = Api.new
        api.sendtext("4125965296", "Reported crime: http://localhost:3000/reports/"+r.id.to_s())
        render :plain => "Created"
    end

    def show()
        id = params[:id]
        report = Report.find_by(id: id)
        render :plain => report.description
    end

    def destroy()
        user = Report.find_by(id: params[:id])
        user.destroy()
        render :plain => "Destroyed"
    end
end
