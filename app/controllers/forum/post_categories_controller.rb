module Forum
    class PostCategoriesController < ApplicationController
      # Your actions (index, show, new, create, etc.)
      def index
        @post_categories = PostCategory.where(published:true)
      end

      def new
        @post_category = PostCategory.new
      end

      def show
        @post_category = PostCategory.find(params[:id])

        @category = PostCategory.find(params[:id])
        @posts = @category.posts.where(published:true)
      end
    
      def create
        @post_category = PostCategory.new(post_category_params)

        @post_category.update(user_id: @current_user.id)

        if @post_category.save
          redirect_to forum_path, notice: 'Category was successfully created.'
        else
          render :new
        end
      end
    
      private
    
      def post_category_params
        params.require(:post_category).permit(:name, :region_id, :description, :category_type)
      end

    end
  end