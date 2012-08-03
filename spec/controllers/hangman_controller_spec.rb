


require 'spec_helper'

describe HangmanController do


describe '#process_letter' do
       
        context "letter clicked is already checked whether it is in the word or not" do       
               
		it "assigns the string 'You have already entered this character. Enter Another character' to @abc" do
                       
		       get :index
                           
    	      		session[:string_entered]= 'adhf'
                        
			session[:word] = 'World'
              		get :process_letter, "id"=>"h", :format => :js
		       
                       assigns(:abc).should eq('You have already entered this character. Enter Another character') 
			
		end 
        end

           
        context "letter clicked is not already entered" do       
             context "letter clicked is not present in session[:word]" do
                
               it "processes the letter" do
                     get :index                           
    	      	     session[:string_entered]= 'adhf'

		     session[:word] = 'World'
              	     get :process_letter, "id"=>"p", :format => :js
                     assigns(:abc).should eq('You have entered wrong letter. ' << (session[:guesses]).to_s << " guesses left") 
                        
               end
             end
             
             context "letter clicked is present in session[:word]" do
                  context "database word and guessed word match" do
                      it "you won" do   
                        get :index
                        session[:string_entered]='lowr'
                       session[:user_string]='worl'
                        session[:word]='World'
                        get :process_letter, "id"=>"d", :format => :js
                        assigns(:abc).should eq(session[:word] << " You win !!!")
                     end
	          end

                                 
                 context "database word and guessed word does not match" do
		    it "displays Worl_" do
                        get :index
                        session[:string_entered]='bowa'
                        session[:user_string]='wo'
                        session[:word]='World'
              	        get :process_letter, "id"=>"r", :format => :js
                        assigns(:abc).should eq(session[:user_string].to_s)
                    end 
                 end 
                
             end


             context "number of remaining guesses is 0" do
                    it " displays you lost " do
                         get :index
                        session[:string_entered]='lowr'
                        session[:user_string]='worl'
                        session[:word]='World'
                        session[:guesses]=1
                        get :process_letter, "id"=>"a", :format => :js
                        assigns(:abc).should eq("Correct word :  " << session[:word] << " <br> You lost")
                    end 
              end  
        end
        
         
end
end 
