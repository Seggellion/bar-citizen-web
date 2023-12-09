# app/models/activity.rb
class Activity < ApplicationRecord
    belongs_to :user

      # Method to extract event_id from description
  def extract_event_id
    model_name, event_id = description.split('-')
    
    # Check if the model_name matches one of the specified types
    if ['event', 'giveaway', 'photo'].include?(model_name)
      return event_id
    end

    nil # Return nil if it's not a matching model
  end

  def associated_with?(event_id, type)
    
    return false unless description


    model_name, id_fragment = description.split('-')
    return false unless model_name == type

    # Extract the actual ID from the id_fragment (e.g., '2' from 'id_2')
    record_id = id_fragment.split('_').last

    # Dynamically find the associated model record
    associated_record = model_name.classify.constantize.find_by(id: record_id)

    # Compare the event_id of the associated record
    associated_record && associated_record.event_id == event_id
  end

end