module Actionable
    def action_user
      User.find_by(id: self.action_id)
    end
  end