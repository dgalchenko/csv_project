require 'csv'

class CompaniesCsvImporter
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def call
    return error_response(:file_missing) unless file.present?
    return error_response(:wrong_format) unless valid_csv_file?

    companies = parse_csv

    return error_response(:no_companies_found) if companies.blank? 

    Company.upsert_all(companies, unique_by: :registry_number)

    { success: true }
  rescue => e
    { success: false, error: e.message }
  end

  private

  def parse_csv
    # TODO: investigate if Postgres has more efficient solutions for big datasets
    companies = {}

    # TODO: consider background jobs in the future, if big files need to be supported
    CSV.foreach(file.path, headers: true, col_sep: ';').each do |row|
      company = {
        registry_number: row["coc_number"],
        name: row["company_name"],
        city: row["city"]
      }

      companies[company[:registry_number]] = company if Company.new(company).valid?
    end

    companies.values
  end

  def valid_csv_file?
    file.original_filename.downcase.ends_with?('.csv') && file.content_type == 'text/csv'
  end

  def error_response(error_key)
    { success: false, error: I18n.t("errors.file.#{error_key}") }
  end
end
