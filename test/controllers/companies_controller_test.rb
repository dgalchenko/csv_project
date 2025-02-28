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

  test "should return success if import went successfully" do
    file = 'file.csv'
    CompaniesCsvImporter.any_instance.expects(:call).returns({ success: true })
    post import_companies_path, params: { file: file }

    assert_redirected_to upload_companies_path
    assert_equal I18n.t('flash.companies.upload_success'), flash[:notice]
  end

  test "should return alert if import failed" do
    file = ''
    CompaniesCsvImporter.any_instance.expects(:call).returns({ success: false, error: I18n.t("errors.file.file_missing") })
    post import_companies_path, params: { file: file }

    assert_redirected_to upload_companies_path
    assert_equal I18n.t('flash.companies.upload_failure', error: I18n.t("errors.file.file_missing")), flash[:alert]
  end

  # TODO: cover all scenarios
end
