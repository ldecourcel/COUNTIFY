class ChatPolicy < ApplicationPolicy

  def show?
    if user.is_accountant?
      @record.accountant_id == user.accountant_id
    elsif user.is_company?
      @record.company_id == user.company_id
    end
  end

end