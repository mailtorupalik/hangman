require 'test_helper'

class HangmanControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get play_game" do
    get :play_game
    assert_response :success
  end

end
