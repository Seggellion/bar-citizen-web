# app/controllers/posts_controller.rb
class ForumController < ApplicationController

    def index
        @posts = Post.where(published:true)
        @post_categories = PostCategory.where(published:true)
    end

   

end