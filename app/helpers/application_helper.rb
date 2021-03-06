module ApplicationHelper

  def owner_is_user(bed)
    current_user == bed.owner
  end

  def bed_bookings(current_user)
    bookings = []
    current_user.beds.each do |bed|
      bed.bookings.where(owner_archive: false).each do |booking|
        bookings << booking
      end
    end
    bookings.sort_by{ |booking| booking.created_at }.reverse!
  end

  def user_pict(user)
    if user.picture.exists?
      user.picture
    else
      "placeholder.png"
    end
  end

  def insurance_pict(user)
    if user.insurance.exists?
      user.insurance
    else
      "placeholder-image.jpg"
    end
  end

  def title
    content_for?(:title) ? content_for(:title) : DEFAULT_META['default_title']
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : DEFAULT_META['meta_description']
  end

  def meta_image
    content_for?(:meta_image) ? content_for(:meta_image) : DEFAULT_META['meta_image']
  end

  def twitter_account
    content_for?(:twitter_account) ? content_for(:twitter_account) : DEFAULT_META['twitter_account']
  end
end
