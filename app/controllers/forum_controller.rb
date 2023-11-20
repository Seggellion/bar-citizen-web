# app/controllers/posts_controller.rb
class ForumController < ApplicationController

    def index
        @posts = Post.all
        @post_categories = PostCategory.all
    end

   

end