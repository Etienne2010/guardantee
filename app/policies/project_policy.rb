class ProjectPolicy < ApplicationPolicy

  def show?
    record.user == current_user
  end

  def create?
    true
  end

  class Scope < Scope
    def resolve
      scope.all

      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end
end
