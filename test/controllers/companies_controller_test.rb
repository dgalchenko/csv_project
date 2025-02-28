require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company1 = FactoryBot.create(:company, name: Faker::Company.name)
    @company2 = FactoryBot.create(:company, name: Faker::Company.name)
  end

  test "shhould get search" do
    get search_companies_path
    assert_response :success
  end

  test "should query search results matching only company1 name" do
    get search_results_companies_path, params: { query: @company1.name }, as: :html
    assert_response :success
    assert_match @company1.name, @response.body
    assert_no_match @company2.name, @response.body
  end

  test "should get upload" do
    get upload_companies_path
    assert_response :success
  end

  # TODO: Add tests for Import part
  # TODO: Add tests for CompaniesCsvImporter service
  # TODO: Add tests for Company model
end
