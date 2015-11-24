class TerritoryMailer < ApplicationMailer

def creation_confirmation(territory)
    @territory = territory

    mail(
      to:       @territory.owner.email,
      subject:  "Félicatation, votre hutte #{@territory.name} a bien été ajoutée !"
    )
  end
end
