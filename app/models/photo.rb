class Photo < ActiveRecord::Base
  belongs_to :territory

  has_attached_file :picture,
    styles: { large: "1000x1000>", medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  process_in_background :picture
end
