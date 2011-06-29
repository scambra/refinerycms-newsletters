class Newsletter < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :email_body]

  validates :title, :presence => true, :uniqueness => true
  validates :template, :email_body, :presence => true
  
  def self.last_number(template)
    self.where(:template => template).where(self.arel_table[:number].not_eq(nil)).order(:number).last.try(:number) || 0
  end
  
  def number
    self[:number] || self.class.last_number(template) + 1
  end

  def send_to_all
    self.emails_sent = 0

    get_subscribers.each do |user|
      begin
        NewsletterMailer.newsletter_email(user.email, self).deliver
        self.emails_sent += 1
      rescue
        logger.warn "There was an error delivering an newsletter .\n#{$!}\n"
      end
    end
    
    self.status = 'sent'
    self.save
  end
  
  private
  def get_subscribers
    User.subscribed
  end
end
