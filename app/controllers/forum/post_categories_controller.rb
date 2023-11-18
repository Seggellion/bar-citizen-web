module Forum
    class PostCategoriesController < ApplicationController
      # Your actions (index, show, new, create, etc.)
      def index
        @post_categories = PostCategory.all
      end
    end
  end