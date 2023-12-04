# app/controllers/admin/dashboard_controller.rb

module Admin
    class CalendarController < ApplicationController
        before_action :authenticate_admin!
        layout 'admin'
        def index
            @current_date = Date.today 
            @events = Event.all
        end

    end

end