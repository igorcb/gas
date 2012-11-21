require 'spec_helper'

describe Launche do
  
  before { @launche = Launche.new(date_launche: Time.now.strftime("%Y/%m/%d"),
                                  miles: 1000,
                                  price: 2.69,
                                  total: 50) }
  subject { @launche }

  it { should respond_to(:date_launche) }
  it { should respond_to(:miles) }
  it { should respond_to(:price) }
  it { should respond_to(:total) }

  it { should be_valid }

  describe "when date_launche not present" do
    before { @launche.date_launche = " " }
    it { should_not be_valid }
  end

  describe "when miles not present" do
    before { @launche.miles = " " }
    it { should_not be_valid }
  end

  describe "when miles not number" do
    before { @launche.miles = "a" }
    it { should_not be_valid }
  end

  describe "when miles is number" do
    before { @launche.miles = 1000 }
    it { should be_valid }
  end

  describe "when price not present" do
    before { @launche.price = " " }
    it { should_not be_valid }
  end

  describe "when total not present" do
    before { @launche.total = " " }
    it { should_not be_valid }
  end

  
end
