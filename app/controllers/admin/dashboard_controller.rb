# app/controllers/admin/dashboard_controller.rb

module Admin
    class DashboardController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'

      def index
        # Dashboard summary data
      end
    end
  end
  