class BookingPolicy < ApplicationPolicy
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
    true
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

  def accept?
    # only the owner can accept a booking, only if it starts in the future
    record.territory.owner == user &&
    record.starting_on >= Date.today &&
    record.status == :pending
  end

  def reject?
    # if starts in the future, both owner and client can reject
    if record.starting_on > Date.today
      (record.territory.owner == user || record.client == user) &&
      (record.status == :pending || record.status == :confirmed)
    # is started in the past, both can reject only if status is pending
    elsif record.starting_on <= Date.today
      (record.territory.owner == user || record.client == user) &&
      record.status == :pending
    end
  end

  def client_archive?
    # if starts in the future, client can archive canceled booking
    if record.starting_on > Date.today
      record.client == user &&
      record.status == :canceled
    # is ended in the past, client can archive any booking
    elsif record.ending_on <= Date.today
      record.client == user
    end
  end

  def owner_archive?
    # if starts in the future, owner can archive canceled booking
    if record.starting_on > Date.today
      record.territory.owner == user &&
      record.status == :canceled
    # is ended in the past, owner can archive any booking
    elsif record.ending_on <= Date.today
      record.territory.owner == user
    end
  end
end
