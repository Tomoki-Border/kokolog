require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "kokolog"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | kokolog"
  end
  
end
