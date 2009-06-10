module ResultsHelper
  def ntc(number, precision = 0)
    number_to_currency(number, :precision => precision)
  end
  
  def nwd(number)
    number_with_delimiter(number)
  end
    
end
