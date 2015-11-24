class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    record.booking.reviews.count < 1 &&
    record.booking.status == :confirmed &&
    record.booking.ending_on <= Date.today &&
    record.booking.client == user
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
end
