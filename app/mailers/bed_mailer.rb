class BedMailer < ApplicationMailer

def creation_confirmation(bed)
    @bed = bed

    mail(
      to:       @bed.owner.email,
      subject:  "Congratulations, your bed #{@bed.name} has been added!"
    )
  end
end
