require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get companies_search_url
    assert_response :success
  end

  test "should get upload" do
    get companies_upload_url
    assert_response :success
  end
end
