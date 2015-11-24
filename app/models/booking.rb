class Booking < ActiveRecord::Base
  extend Enumerize

  monetize :total_price_cents

  belongs_to :territory
  belongs_to :client, class_name: "User", foreign_key: "client_id"
  has_many :reviews, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates_presence_of :client, :territory, :starting_on, :ending_on, :nb_days, :status, :checkout_status
  enumerize :status, in: [:checkout, :pending, :confirmed, :canceled], default: :checkout
  enumerize :checkout_status, in: [:cart, :address, :payment, :paid], default: :cart

  validate :date_must_be_in_future, if: :new_record?

  def self.start_date_after_end_date?(starting_on, ending_on)
    starting_on > ending_on
  end

  def self.booked?(territory_id, starting_on, ending_on)
    @bookings = Booking.where(territory_id: territory_id)

    if @bookings.empty?
      return false
    else
      @bookings.each do |booking|
        if booking.starting_on.nil? || booking.starting_on == 0
          return false
        elsif booking.starting_on <= starting_on && starting_on <= booking.ending_on
          return true
        elsif starting_on <= booking.starting_on && booking.starting_on <= ending_on
          return true
        elsif starting_on <= booking.starting_on && booking.ending_on <= ending_on
          return true
        else
          return false
        end
      end
    end
  end

  private

  def date_must_be_in_future
    if self.starting_on < Date.today
      errors.add(:starting_on, :invalid)
    end
  end
end
