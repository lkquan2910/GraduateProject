module DateTimeHelper
  def format_date date
    date.localtime.strftime Settings.date.formats.strftime_date_time_vi
  end

  def format_task_date date
    date.localtime.strftime Settings.date.formats.strftime_short
  end

  def format_regulation date
    return '' unless date
    date.localtime.strftime Settings.date.formats.strftime_regulation
  end
end
