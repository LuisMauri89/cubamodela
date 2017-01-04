# Preview all emails at http://localhost:3000/rails/mailers/custom_mailer
class CustomMailerPreview < ActionMailer::Preview
	def email_message_send
		CustomMailer.email_message_send(ProfileModel.find(45), "sjfje gjoejgoi hgujeig giegie gegieig eug geugi eog eguiu g gsge gueg89uwtioewut gwapgtug gskfsf sdvs gwjuwgiesghgsu hguhweu fewsfguwgueshguweaggoehg gh eg egeg wwe rgu erg. Thanks...")
	end

	def email_admin_send_opinion
		CustomMailer.email_admin_send_opinion(User.where(role: "admin").first, "sjfje gjoejgoi hgujeig giegie gegieig eug geugi eog eguiu g gsge gueg89uwtioewut gwapgtug gskfsf sdvs gwjuwgiesghgsu hguhweu fewsfguwgueshguweaggoehg gh eg egeg wwe rgu erg. Thanks...", DateTime.now)
	end
end
