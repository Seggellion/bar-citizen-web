# app/services/badge_awarding_service.rb
class BadgeAwardingService
    def initialize(user)
      @user = user
    end
  
    def call
      rule_classes.each do |rule_class|
        rule = rule_class.new(@user)
        if rule.applicable?
          award_badge(rule.badge_name)
        end
      end
    end
  
    private
  


    def award_badge(badge_name)
        
        badge = Badge.find_by(name: badge_name)
        Rails.logger.info "Badge processed: #{badge.inspect}" # Debugging statement
      
        if badge.persisted?
          # Check if the user already has this badge
          existing_user_badge = UserBadge.find_by(user: @user, badge: badge)
          if existing_user_badge
            Rails.logger.info "User already has badge: #{badge_name}"
            return # Exit the method if the badge already exists for the user
          end
      
          # Create the UserBadge since it doesn't exist
          UserBadge.create(user: @user, badge: badge, earned_at: Time.current)
          Rails.logger.info "Awarded new badge: #{badge_name}"
        else
          Rails.logger.error "Failed to create/find badge with name: #{badge_name}"
        end
      end
      
      
  
    def rule_classes
      [
        BadgeRules::AlphaTesterRule,
        BadgeRules::AvocadoBadgeRule,
        # Add other rule classes here
      ]
    end
  end
  