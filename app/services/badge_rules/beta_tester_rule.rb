# app/services/badge_rules/alpha_tester_rule.rb
module BadgeRules
    class BetaTesterRule < BadgeRule
      def applicable?
        @user.created_at < Time.new(2024, 8, 15)
      end
  
      def badge_name
        'Beta Testers'
      end
    end
  end
  