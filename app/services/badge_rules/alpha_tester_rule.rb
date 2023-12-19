# app/services/badge_rules/alpha_tester_rule.rb
module BadgeRules
    class AlphaTesterRule < BadgeRule
      def applicable?
        @user.created_at < Time.new(2024, 1, 15)
      end
  
      def badge_name
        'Alpha Testers'
      end
    end
  end
  