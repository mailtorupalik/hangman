require 'spec_helper'

describe "Hangmen" do
  describe "GET /index" do
    #it "works! (now wriite some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
     # get hangmen_path
     # response.status.should be(200)
       it "should have the content 'Hangman'" do
            visit '/hangman' 
         #   save_and_open_page
            page.has_content?('Hangman')   
       end
       
	it "displays You have entered wrong letter 5 guesses left" do
            visit '/hangman'  
                 
        end   

    end
  end
