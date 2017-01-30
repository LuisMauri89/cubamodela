class Bank

	# Charge
    def self.charge(profile, amount, action, use_card)
	    if use_card
	    else
	    	wallet_amount = profile.wallet.amount.to_f

	    	if wallet_amount >= amount
		        if profile.wallet.charge(amount)
		          Charge.create(profileable: profile, wallet_charge_amount: amount, on_action: action)
		          return true, nil
		        else
		          return false, I18n.t('views.bank.messages.wallet_charge_failed')
		        end
	    	else
	        	return false, I18n.t('views.bank.messages.wallet_amount_insuficient')
	    	end
	    end
    end
end