class BedMailerPreview < ActionMailer::Preview

  def creation_confirmation
    bed = Bed.first
    BedMailer.creation_confirmation(bed)
  end
end
