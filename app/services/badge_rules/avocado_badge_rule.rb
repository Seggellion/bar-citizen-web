# app/services/badge_rules/avocado_badge_rule.rb
module BadgeRules
    class AvocadoBadgeRule < BadgeRule
      def applicable?

        created_post? &&
        created_reply? &&
        created_photo? &&
        created_photo_comment? &&
        created_event? &&
        created_discord? &&
        created_message?
      end
  
      def badge_name
        'Avocado'
      end
  
      private
  
      def created_post?
        @user.posts.exists?
      end
  
      def created_reply?
        @user.replies.joins(:post).where.not(posts: { user_id: @user.id }).exists?
      end
  
      def created_photo?
        @user.photos.exists?
      end
  
      def created_photo_comment?
        @user.photo_comments.joins(:photo).where.not(photos: { user_id: @user.id }).exists?

      end
  
      def created_event?
        @user.events.exists?
      end
  
      def created_discord?
        @user.discords.exists?
      end
  
      def created_message?
        @user.sent_messages.exists?
      end
  
    end
  end
  