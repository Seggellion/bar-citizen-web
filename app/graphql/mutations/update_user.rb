# app/graphql/mutations/update_user.rb
module Mutations
    class UpdateUser < BaseMutation
      argument :id, ID, required: true
      argument :username, String, required: false
      argument :email, String, required: false
      argument :profile_image, String, required: false
      # Add other arguments for fields you want to be able to update
  
      type Types::UserType
  
      def resolve(id:, **attributes)
        user = User.find(id)
        user.update!(attributes)
        user
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new('User not found')
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
  