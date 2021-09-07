require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "TwiLike"
  end

  test "should get root" do
    get root_url
    assert_response :success
  end

  # test "should get home" do
  #   get static_pages_home_url
  #   assert_response :success
  #   assert_select "title", "Home | #{@base_title}"
  # end

  test "should get help" do
    get help_url
    assert_response :success
    assert_select "title", "ヘルプ | #{@base_title}"
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "その他 | #{@base_title}"
  end

end
