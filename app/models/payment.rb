class Payment < ActiveRecord::Base
  extend Enumerize

  belongs_to :credit_card
  belongs_to :booking

  enumerize :state, in: %w(pending accepted refused error), default: :pending
  monetize :amount_cents

  def charge
    self.booking.territory.owner.create_or_update_wallet
    mangopay_request = {
      AuthorId: self.booking.client.mangopay_user_id,
      DebitedFunds: {
          Currency: "EUR",
          Amount: self.amount_cents
      },
        Fees: {
          Currency: "EUR",
          Amount: self.amount_cents * 0.15
      },
      CreditedWalletId: self.booking.territory.owner.mangopay_wallet_id,
      CardId: self.credit_card.mangopay_card_id,
      SecureModeReturnURL: 'https://www.elysee.fr'
    }

    begin
      response = MangoPay::PayIn::Card::Direct.create(mangopay_request)
      self.mangopay_response = response
      self.mangopay_payin_id = response["Id"]

      if response["Status"] == 'SUCCEEDED'
        self.state = :accepted
      else
        self.state = :refused
      end
    rescue MangoPay::ResponseError => e
      self.mangopay_response = e.details
      self.state = :error
    end

    self.save
  end
end
