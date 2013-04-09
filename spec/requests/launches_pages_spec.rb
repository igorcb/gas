require 'spec_helper'

describe "Launches Pages" do
  MASKDATA = "%Y-%m-%d"
  time = Time.now.strftime(MASKDATA)

  subject { page }

  describe "index" do
    before do
      FactoryGirl.create(:launche, date_launche: time, miles: 1000, price: 2.69, total: 50.00 )
      FactoryGirl.create(:launche, date_launche: time, miles: 2000, price: 2.79, total: 50.00 )
      visit launches_path
    end

    it { should have_selector('h1',    text: 'All Launches') }
    it { should have_selector('title', text: 'All Launches') }
    it { should have_link('New Launch', href: new_launch_path )}

    it "should list each launches" do
      Launche.all.each do |launche|
        page.should have_selector('td', text: launche.date_launche.to_s)
        page.should have_selector('td', text: launche.miles.to_s)
        page.should have_selector('td', text: launche.price.to_s)
        page.should have_selector('td', text: launche.total.to_s)
      end
    end

    describe "delete links" do
      it { should have_link('delete', href: launch_path(Launche.first)) }

      it "should be able to delete launch" do
        expect { click_link('delete') }.to change(Launche, :count).by(-1)
      end
    end
  end

  describe "show" do
    let(:launche) { FactoryGirl.create(:launche) }
    before do 
      visit launch_path(launche)
    end
    it { should have_selector('h1',    text: 'Launche') }
    it { should have_selector('title', text: 'Launche' ) }
    it { should have_selector('p', text: 'Date:' ) }
    it { should have_selector('p', text: launche.date_launche.to_s ) }
    it { should have_selector('p', text: 'Miles:' ) }
    it { should have_selector('p', text: launche.miles.to_s ) }
    it { should have_selector('p', text: 'Price:' ) }
    it { should have_selector('p', text: launche.price.to_s ) }
    it { should have_selector('p', text: 'Total:' ) }
    it { should have_selector('p', text: launche.total.to_s ) }

    it { should have_link('All launche', href: launches_path )}
  end

  describe "new" do
    before { visit new_launch_path }

    let(:submit) { "Create launche" }
    
    it { should have_link('All launche', href: launches_path )}

    describe "with invalid information" do
      it "should not create a launche" do
        expect { click_button submit }.not_to change(Launche, :count)
      end
    end

    describe "with valid information" do
      before do
        #fill_in "Date",  with: time
        have_date_select "#{Time.now.year}", :from => "Date"
        have_date_select "#{Time.now.month}", :from => "month"
        have_date_select "#{Time.now}", :from => "day"
        fill_in "Miles", with: 1000
        fill_in "Price", with: 2.69
        fill_in "Total", with: 50.00
      end
      
      it "should create a launche" do
        expect { click_button submit }.to change(Launche, :count).by(1)
      end

      describe "after saving the launche" do
        before { click_button submit }
        #let(:launche) { Launche.find_by_date_launche_and_miles(time, 1000) }
        let(:launche) { Launche.last }

        # it { should have_selector('title', text: "Launche") }
        # it { should have_selector('h1', text: "Launche") }
        it { should have_selector('div.alert.alert-success', text: "created") }
        # it { should have_selector('p', text: 'Date:' ) }
        # it { should have_selector('p', text: launche.date_launche.to_s ) }
        # it { should have_selector('p', text: 'Miles:' ) }
        # it { should have_selector('p', text: launche.miles.to_s ) }
        # it { should have_selector('p', text: 'Price:' ) }
        # it { should have_selector('p', text: launche.price.to_s ) }
        # it { should have_selector('p', text: 'Total:' ) }
        # it { should have_selector('p', text: launche.total.to_s ) }
        it "should list each launches" do
          Launche.all.each do |launche|
            page.should have_selector('td', text: launche.date_launche.to_s)
            page.should have_selector('td', text: launche.miles.to_s)
            page.should have_selector('td', text: launche.price.to_s)
            page.should have_selector('td', text: launche.total.to_s)
          end
        end
      end
    end
  end 

  describe "edit" do
    let(:launche) { FactoryGirl.create(:launche) }
    before { visit edit_launch_path(launche) }

    describe "page" do
      it { should have_selector('h1', text: "Update Launche") }
      it { should have_selector('title', text: 'Edit Launche' ) }
    end

    describe "with invalid information" do
      before do
        fill_in "Date",  with: ""
        fill_in "Miles", with: ""
        fill_in "Price", with: ""
        fill_in "Total", with: ""
        click_button "Save changes"
      end      
      it { should have_content('error') }
    end

    describe "with valid information" do
      data = Time.now + 1.day
      let(:new_date)  { data.strftime(MASKDATA) }
      let(:new_miles) {  2000 }
      let(:new_price) {  2.99 }
      let(:new_total) { 90.00 }

      before do
        fill_in "Date",  with: new_date
        fill_in "Miles", with: new_miles
        fill_in "Price", with: new_price
        fill_in "Total", with: new_total
        click_button "Save changes"
      end

      it { should have_selector('title', text: "Launche") }
      it { should have_selector('div.alert.alert-success') }
      specify { launche.reload.date_launche.to_s.should  == new_date }
      specify { launche.reload.miles.to_i.should == new_miles }
      specify { launche.reload.price.to_f.should == new_price }
      specify { launche.reload.total.to_f.should == new_total }

    end
  end


end
