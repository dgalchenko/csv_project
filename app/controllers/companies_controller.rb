class CompaniesController < ApplicationController
  def search; end

  def upload; end

  def search_results
    query_search_pattern = "%#{search_params[:query]}%"
    @companies = Company.where('registry_number ILIKE :query OR name ILIKE :query OR city ILIKE :query', query: query_search_pattern)

    respond_to do |format|
      format.html { render partial: 'companies/search_results_list', locals: { companies: @companies } }
    end
  end

  def import
    result = CompaniesCsvImporter.new(file_params[:file]).call

    if result[:success]
      redirect_to upload_companies_path, notice: I18n.t('flash.companies.upload_success')
    else
      redirect_to upload_companies_path, alert: I18n.t('flash.companies.upload_failure', error: result[:error])
    end
  end

  private

  def search_params
    params.permit(:query)
  end

  def file_params
    params.permit(:file)
  end
end
