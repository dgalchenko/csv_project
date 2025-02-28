require "test_helper"
require "tempfile"

class CompaniesCsvImporterTest < ActionDispatch::IntegrationTest
  test "should successfully import a valid CSV" do
    file = Tempfile.new(['test_valid_companies', '.csv'])
    file.stubs(:content_type).returns('text/csv')
    file.stubs(:original_filename).returns('test_valid_companies.csv')
    companies = [
      {
        :registry_number=>Faker::Number.number(digits: 10).to_s,
        :name=>Faker::Company.name,
        :city=>Faker::Address.city
      }
    ]

    CompaniesCsvImporter.any_instance.expects(:parse_csv).returns(companies)
    
    result = CompaniesCsvImporter.new(file).call

    assert result[:success]
  end

  test "should return error if wrong format" do
    file = Tempfile.new(['test_valid_companies', '.csv'])
    file.stubs(:content_type).returns('pdf')
    file.stubs(:original_filename).returns('test_valid_companies.csv')

    result = CompaniesCsvImporter.new(file).call

    assert result[:error]
  end

  # TODO: cover all scenarios
end
