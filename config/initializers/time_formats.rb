ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:default]='%d %b %Y'

class Date
  def first_friday
    self + (5 - self.wday).divmod(7)[1].days
  end
end
class Fixnum
  def weeks_in_year
    first_weekday = Date.civil(self,1,1).wday
    if first_weekday == 5 || (first_weekday == 4 && Time.days_in_month(2, self) == 29)
      return 1..53
    else
      return 1..52
    end
  end
end
