# app/controllers/admin/posts_controller.rb

module Admin
    class SectionsController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'


      def create
        section_type = params[:section][:section_type]
        sectionable_attributes = { title: params[:section][:title] }
        
        sectionable = create_sectionable(section_type, sectionable_attributes)
        
        if sectionable&.valid?  # Use valid? to check validity before saving
          
          @section = Section.new(section_params.merge(sectionable: sectionable))
      
          if @section.save
            redirect_to admin_settings_path, notice: 'Section was successfully created.'
          else
            # Handle errors for Section
            redirect_to admin_settings_path, notice: 'Section Did not save.'
          end
        else
          # Handle errors for sectionable object
          redirect_to admin_settings_path, notice: 'Section did not save'
        end
      end
    

      def update
        @section = Section.find(params[:id])
        
        respond_to do |format|
          if @section.update(section_params)
            redirect_to admin_settings_path, notice: 'Section was successfully updated.'
            format.json { render :show, status: :ok, location: @section }
          else
            redirect_to admin_settings_path, notice: 'Section was successfully updated.'
            format.json { render json: @section.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @section = Section.find(params[:id])
        @section.destroy
        redirect_to admin_settings_path, notice: 'Section was successfully deleted.'
      end

      def trash
        
        reply = Section.find(params[:id])
        reply.update(trashed: true, action_id: @current_user.id)
    
        author = User.find(reply.user_id)

        redirect_to admin_replies_path, notice: 'Section was successfully trashed.'
        # Redirect or render as needed
      end

      private

        def section_params
            params.require(:section).permit(:section_order, :page_id)
        end

        def create_sectionable(type, attributes)
            case type
            when 'VideoSection'
              VideoSection.new(attributes)
            when 'TwoByTwoGridSection'
              TwoByTwoGridSection.new(attributes)
            when 'ContentSection'
              ContentSection.new(attributes)
            when 'HeroSection'
              HeroSection.new(attributes)
            when 'ThreeGridSection'
              ThreeGridSection.new(attributes)
            else
              nil # Unknown type
            end
          end

    end
  end
  