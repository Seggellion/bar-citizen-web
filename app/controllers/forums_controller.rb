# app/controllers/posts_controller.rb
class ForumsController < ApplicationController

    def index
        @posts = Post.all
    end

end