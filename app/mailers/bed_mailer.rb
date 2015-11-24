class BedMailer < ApplicationMailer

def creation_confirmation(bed)
    @bed = bed

    mail(
      to:       @bed.owner.email,
      subject:  "Félicatation, votre hutte #{@bed.name} a bien été ajoutée !"
    )
  end
end
