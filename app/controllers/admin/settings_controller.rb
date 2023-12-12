# app/controllers/admin/dashboard_controller.rb

module Admin
    class SettingsController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'

      def edit
        @section = Section.find(params[:id])
        @section.blocks.each do |block|
          ['en', 'ja'].each do |lang|
            block.translations.find_or_initialize_by(language: lang)
          end
        end
      end

      def index
        # Dashboard summary data
        @section = Section.new
        @sections = Section.all
      end
    end
  end
  