class Launche < ActiveRecord::Base
  attr_accessible :date_launche, :miles, :price, :total

  validates :date_launche, :price, :total, presence: true
  validates :miles, presence: true, numericality: true
end
