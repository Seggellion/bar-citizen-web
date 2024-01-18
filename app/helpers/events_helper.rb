module EventsHelper
  def format_event_datetime(start_datetime, end_datetime, user_timezone)
    start_datetime = start_datetime.in_time_zone(user_timezone)
    end_datetime = end_datetime.in_time_zone(user_timezone)

    if start_datetime.to_date == end_datetime.to_date
      "#{start_datetime.strftime("%b %e %Y (%A %l%P")} - #{end_datetime.strftime("%l%P")})"
    else
      "#{start_datetime.strftime("%b %e %Y (%A %l%P")} - #{end_datetime.strftime("%b %e %Y (%A %l%P")})"
    end
  end

  def timezone_abbreviation(timezone_identifier)
    tz = TZInfo::Timezone.get(timezone_identifier)
    tz.current_period.abbreviation.to_s
  rescue TZInfo::InvalidTimezoneIdentifier
    ''
  end

end
