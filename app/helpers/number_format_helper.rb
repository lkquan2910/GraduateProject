module NumberFormatHelper
  def currency number
    number_to_currency(number, precision: 0, unit: '', delimiter: '.', separator: ',')
  end

  def acreage number
    number_to_currency(number, precision: 1, unit: '', delimiter: '.', separator: ',')
  end
end
