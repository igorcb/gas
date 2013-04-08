class Launche < ActiveRecord::Base
  attr_accessible :date_launche, :miles, :price, :total

  validates :date_launche, :price, :total, presence: true
  validates :miles, presence: true, numericality: true

  scope :by_year, lambda { |year| where('extract(year from date_launche) = ?', year) }

  def self.total_launche_year(year)
    Launche.where('extract(year from date_launche) = ?', year).sum('total')
  end

  def self.total_launche_year_month(year)
    Launche.where('extract (year FROM date_launche) = ?', year).group('extract (month FROM date_launche)').sum('total').sort
  end

  def self.miles_travel_year(year)
  	miles_first = Launche.where('extract (year FROM date_launche) = ?', year).order('miles').first
  	miles_last  = Launche.where('extract (year FROM date_launche) = ?', year).order('miles').last

  	result = (miles_last.miles.to_i - miles_first.miles.to_i)
  	result
  end

  def self.miles_travel_year_and_month(year, month)
    miles_first = Launche.where('extract (year FROM date_launche) = ? and extract (month FROM date_launche) = ? ', year, month).order('miles').first
    miles_last  = Launche.where('extract (year FROM date_launche) = ? and extract (month FROM date_launche) = ? ', year, month).order('miles').last

    result = (miles_last.miles.to_i - miles_first.miles.to_i)
    result
  end

end
