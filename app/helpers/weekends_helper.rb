module WeekendsHelper
  def wts(weekend)
    friday = Date.civil(weekend.year,1,1).first_friday + (weekend.week-1).weeks
    sunday = friday + 2.days
    "#{friday.to_s} &mdash; #{sunday.to_s}"
  end

  def starts(weekend)
    friday = Date.civil(weekend.year,1,1).first_friday + (weekend.week-1).weeks
    "#{friday.to_s}"
  end

end
