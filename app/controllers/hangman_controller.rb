class HangmanController < ApplicationController

  respond_to :html, :js
 
  def start_new_game
        render(:action => 'index')     
  end 
  
  def index
         @start=""
	 session[:string_entered]=""
 	 @abc = ""

	 @simplew=Dictionary.find(:all,:order => 'RAND()',:limit => 1)  #fetch a random record from dictionary table
 	 session[:word]=@simplew.first.word
					
	 # session[:word] = "Rupali"
  	 session[:user_string] = "-" * session[:word].size
  	 session[:guesses] = 6
  end

  def process_letter
  
      letter_pressed = params[:id]
    
     if session[:string_entered].include? letter_pressed
             @abc = 'You have already entered this character. Enter Another character'
     else
             session[:string_entered] << letter_pressed
	     position=session[:word].downcase.index(letter_pressed.downcase)     #get the index of letter_pressed
      
         if !( position.nil? )                #if position is not nil 
         	        for i in position...session[:word].size
                	    if session[:word][i].downcase.chr == letter_pressed.downcase
                        	  session[:user_string][i] = letter_pressed.downcase
                            end
                    
                    	    if session[:word][i].downcase.chr == ' '
                            	  session[:user_string][i] = ' '
                    	    end
                        end
        
                        if session[:user_string].downcase == session[:word].downcase
           	    		@abc = session[:word] << " <br>  You win !!!"
              		else
              	   		@abc = session[:user_string]
              		end 
        
         else
         	     @abc = 'You have entered wrong letter. ' << (session[:guesses] - 1).to_s << " guesses left"
             	     session[:guesses] = session[:guesses] - 1
        

     		     if session[:guesses] ==0
              	     @abc = "Correct word :  " << session[:word] << " <br> You lost"
                     #index
                     start_new_game
         	     end
      
         end
     end
#  @guess=session[:guesses]
  respond_with @abc
  end

def start_new_game
 
                       @start="hello"
                       respond_with @start
end

end
