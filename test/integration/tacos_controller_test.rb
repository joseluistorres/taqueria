require "test_helper"

class TacosFlowTest < Capybara::Rails::TestCase
  describe "TacosFlow" do
    fixtures :all

    describe "GET #index" do
      it "renders the index action for Tacos and submit the form to filter by Name" do
        visit tacos_url
        page.must_have_content "De Barbacoa"
        page.must_have_content "De Labio"

        fill_in("Name", :with => "Labio")
        click_button("Filter")
        page.must_have_content "De Labio"
        page.has_no_content?("De Barbacoa")
      end

      it "renders the index action for Tacos and submit the form to filter by Spicy(ness)" do
        visit tacos_url
        page.must_have_content "De Barbacoa"
        page.must_have_content "De Labio"

        select(true, from: "filter_spicy")
        click_button("Filter")
        page.must_have_content "De Adobada"
        page.has_no_content?("De Barbacoa")
        page.has_no_content?("De Labio")
      end

      it "renders the index action for Tacos and submit the form to filter by Meat type" do
        visit tacos_url
        page.must_have_content "De Barbacoa"
        page.must_have_content "De Labio"
        page.must_have_content "De Adobada"

        select("Pork", from: "filter_meat")
        click_button("Filter")
        page.must_have_content "De Adobada"
        page.must_have_content "De Barbacoa"
        page.has_no_content?("De Labio")
      end
    end
  end
end
