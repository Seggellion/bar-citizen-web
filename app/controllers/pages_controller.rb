class PagesController < ApplicationController
    # Action for standard pages
    def show
      @page = Page.find_by(slug: params[:title])
      if current_user
      @avocado_badge_rule = BadgeRules::AvocadoBadgeRule.new(current_user)
      end
      # Handle page not found
      render_404 unless @page
    end
  
    # Action for nested pages
    def show_nested
      @page = Page.find_by(title: params[:title], category: params[:category])
      # Handle page not found
      render_404 unless @page
    end
  
    private
  
    def render_404
      @is_404_page = true
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end
  end
  