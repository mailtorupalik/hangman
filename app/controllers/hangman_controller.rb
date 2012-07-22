class HangmanController < ApplicationController

  respond_to :html, :js
  
  def index
	session[:string_entered]=""
	@abc = ""

@simplew=Dictionary.find(:all,:order => 'RAND()',:limit => 1, )

session[:word]=@simplew.first.word
					
#@simplew=Mysql.query("SELECT word FROM dictionaries ORDER BY RAND() LIMIT 1;")
 #@abc=session[:word]
 # session[:word] = "Rupali"
  session[:user_string] = "_" * session[:word].size
  session[:guesses] = 7
  respond_to do |format|
      format.html
    end
  end

  def process_letter
  letter_pressed = params[:id]
    
    if session[:string_entered].include? letter_pressed
      @abc = 'You have already entered this character. Enter Another character'
    else
      session[:string_entered] << letter_pressed
      position = session[:word].downcase =~ /#{letter_pressed.downcase}/
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
          @abc = session[:word] << " <br>  You win"
        else
         @abc = session[:user_string]
        end 
      else
        @abc = 'You have entered wrong letter. ' << (session[:guesses] - 1).to_s << " guesses left"
        session[:guesses] = session[:guesses] - 1
        if session[:guesses] ==1
          @abc = "Correct word :  " << session[:word] << " <br> You lose"
        end
      end
    end
  respond_with @abc
  end

  def ajax_trial
    respond_with @abc = "abc_abcde"
  # session[:string_entered] << "z"
  #respond_with @abc 
  # respond_to do |format|
  #   format.html { redirect_to('hangman') }
  #   format.js 
  #  end
  #respond_to do |format|
    #format.html { redirect_to('index') }
   #     format.js
   # end
  
  end

end
