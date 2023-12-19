# app/services/badge_rules/badge_rule.rb
module BadgeRules
    class BadgeRule
      def initialize(user)
        @user = user
      end
  
      def applicable?
        raise NotImplementedError
      end
  
      def badge_name
        raise NotImplementedError
      end
    end
  end
  