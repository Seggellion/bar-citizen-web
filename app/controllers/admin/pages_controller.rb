# app/controllers/admin/posts_controller.rb

module Admin
    class PagesController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      def index
        @pages = Page.all
        @page = Page.new
      end

      def create
        
        @page = Page.new(page_params)
        @page.update(user_id: current_user.id)
        if @page.save
          redirect_to admin_pages_path, notice: 'Page was successfully created.'
        else
          render :new
        end
      end

      def update
        @page = Page.find(params[:id])
        
        respond_to do |format|
          if @page.update(page_params)
            redirect_to admin_pages_path, notice: 'Page was successfully updated.'
            format.json { render :show, status: :ok, location: @page }
          else
            redirect_to admin_settings_path, notice: 'Page was successfully updated.'
            format.json { render json: @page.errors, status: :unprocessable_entity }
          end
        end
      end

    
  
      def edit
        @page = Page.find(params[:id])
        @page.sections&.each do |section|
          section.blocks.each do |block|
            ['en', 'ja'].each do |lang|
              block.translations.find_or_initialize_by(language: lang)
            end
          end
        end
        
      end

      

      def trash
        
        reply = Page.find(params[:id])
        reply.update(trashed: true, action_id: @current_user.id)
    
        author = User.find(reply.user_id)
        author.update(karma: author.karma - 200, fame: author.fame - 200)
        redirect_to admin_replies_path, notice: 'Page was successfully trashed.'
        # Redirect or render as needed
      end

      private

      def page_params
        params.require(:page).permit(:title, :description, :category, :slug, :banner)
      end
    end
  end
  