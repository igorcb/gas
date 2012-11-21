require 'spec_helper'

describe "Launches Pages" do
  time = Time.now.strftime("%Y/%m/%d")

  subject { page }

  describe "show" do
    let(:launche) { FactoryGirl.create(:launche) }
    before do 
      visit launch_path(launche)
    end
    it { should have_selector('h1',    text: 'Launches') }
    it { should have_selector('title', text: 'Launches' ) }
  end

  describe "new" do
    before { visit new_launch_path }

    let(:submit) { "Create launche" }

    describe "with invalid information" do
      it "should not create a launche" do
        expect { click_button submit }.not_to change(Launche, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Date", with: time
        fill_in "Miles", with: 1000
        fill_in "Price", with: 2.69
        fill_in "Total", with: 50
      end
      
      it "should create a launche" do
        expect { click_button submit }.to change(Launche, :count).by(1)
      end
    end
  end 
end
