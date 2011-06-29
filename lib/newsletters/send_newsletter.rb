module Refinery::Newsletters
  module SendNewsletter
    
    def get_subscribers
      User.suscripted
    end

    def send_to_all(newsletter)
      number_of_sent_email = 0

      get_subscribers.each do |user|
        begin
          NewsletterMailer.newsletter_email(user.email, newsletter).deliver
          number_of_sent_email = number_of_sent_email + 1
        rescue
          logger.warn "There was an error delivering an newsletter .\n#{$!}\n"
        end
      end
      
      n = Newsletter.find(newsletter)
      n.emails_sent = number_of_sent_email
      n.status = 'sent'
      n.save
    end
  end
end
