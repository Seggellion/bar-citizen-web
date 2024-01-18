module ApplicationHelper

    def comment

    end

    def custom_time_ago_in_words(to_time, include_seconds = false)
        distance_of_time_in_words(Time.now, to_time, include_seconds: include_seconds, accumulate_on: :days)
      end
      

end
