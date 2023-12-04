# app/controllers/admin/posts_controller.rb

module Admin
    class PhotosController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      def index
        @photos = Photo.where(trashed: nil, published: nil).or(Photo.where(trashed: nil, published: false))
      end
  
      # ... other CRUD actions ...


      def unpublished
        @photos = Photo.where(published:false)
      end
  
      def publish
        photo = Photo.find(params[:id])
  
        photo.update(published: true, action_id: @current_user.id)
    
        Activity.create(name: "New photo created", description: "photo-id_#{@photo.id}", user_id: photo.user_id)
        redirect_to admin_photos_path, notice: 'Photo was successfully published.'
  
      end
    
      def unpublish
        photo = Photo.find(params[:id])
  
        photo.update(published: nil, action_id: @current_user.id)
    
        Activity.create(name: "Photo unpublished", user_id: photo.user_id)
        redirect_to admin_photos_path, notice: 'Photo was successfully unpublished.'
  
      end
  
      def trash
        
        photo = Photo.find(params[:id])
        photo.update(trashed: true, action_id: @current_user.id)
        redirect_to admin_photos_path, notice: 'Photo was successfully trashed.'
        unless photo.user.user_type < 2
        author = User.find(photo.user_id)
        author.update(karma: author.karma - 200, fame: author.fame - 200)
        end
        # Redirect or render as needed
      end

    end
  end
  