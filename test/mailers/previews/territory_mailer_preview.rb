class TerritoryMailerPreview < ActionMailer::Preview

  def creation_confirmation
    territory = Territory.first
    TerritoryMailer.creation_confirmation(territory)
  end
end
