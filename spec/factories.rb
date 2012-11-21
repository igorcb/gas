FactoryGirl.define do
  factory :launche do
    date_launche  Time.now.strftime("%Y/%m/%d")
    miles   1000
    price   2.69
    total   50
  end
end