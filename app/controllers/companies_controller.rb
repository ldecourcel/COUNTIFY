class CompaniesController < ApplicationController

  def index
    @companies = policy_scope(Company).order(created_at: :desc)
  end
end
