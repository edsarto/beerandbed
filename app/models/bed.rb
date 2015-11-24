class Bed < ActiveRecord::Base
  extend Enumerize

  monetize :price_cents

  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  has_many :bookings, dependent: :destroy
  has_many :photos,   dependent: :destroy

  has_many :reviews,  through: :bookings

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  enumerize :category, in: [:hutte, :marais, :autre]

  validates_presence_of :owner, :name, :street, :zipcode, :city, :price, :picture
  validates_format_of :zipcode,
    with: /\A[0-9]{5}\z/,
    message: "Zip code should be valid" ;

  has_attached_file :picture,
    styles: { large: "1000x1000>", medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  process_in_background :picture

  def available_dates
    default_scope = Date.today.step(Date.today + 1.year).to_a
    return default_scope - self.reserved_dates
  end

  def available_between(starting_on, ending_on)
    dates = starting_on.step(ending_on).to_a.select do |day|
      reserved_dates.include?(day)
    end

    dates.size == 0
  end

  def full_address
    "#{street}, #{zipcode} #{city}"
  end

  def reserved_dates
    dates = []

    self.bookings.each do |booking|
      unless booking.status == :canceled
        booking.starting_on.step(booking.ending_on).to_a.each do |day|
          dates << day
        end
      end
    end

    return dates.uniq.sort
  end

  private

  def full_address_changed?
    street_changed? || city_changed? || zipcode_changed?
  end
end
