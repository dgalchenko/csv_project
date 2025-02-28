class CompaniesController < ApplicationController
  def search; end

  def upload; end

  def search_results
    query_search_pattern = "%#{permitted_params[:query]}%"
    @companies = Company.where('registry_number ILIKE :query OR name ILIKE :query OR city ILIKE :query', query: query_search_pattern)

    respond_to do |format|
      format.html { render partial: 'companies/search_results_list', locals: { companies: @companies } }
    end
  end

  private

  def permitted_params
    params.permit(:query)
  end
end
