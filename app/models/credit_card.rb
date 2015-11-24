class CreditCard < ActiveRecord::Base
  belongs_to :user, required: true

  has_many :payments, dependent: :nullify

  def to_s
    self.name
  end
end
