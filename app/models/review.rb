class Review < ActiveRecord::Base

  belongs_to :booking
  has_one :bed, through: :booking

  validates_presence_of :booking, :rating, :comment

  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }, numericality: true

end
