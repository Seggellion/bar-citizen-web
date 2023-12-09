module EventsHelper
    def format_event_datetime(start_datetime, end_datetime)
      if start_datetime.to_date == end_datetime.to_date
        "#{start_datetime.strftime("%b %e %Y (%A %l%P")} - #{end_datetime.strftime("%l%P")})"
      else
        "#{start_datetime.strftime("%b %e %Y (%A %l%P")} - #{end_datetime.strftime("%b %e %Y (%A %l%P")})"
      end
    end
  end