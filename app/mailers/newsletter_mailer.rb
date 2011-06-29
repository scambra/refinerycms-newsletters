class NewsletterMailer < ActionMailer::Base

  def newsletter_email(email, newsletter)
    @newsletter = newsletter
    mail(
      :from => RefinerySetting[:email, {:scoping => 'newsletters'}],
      :to => email,
      :subject => newsletter.title
    ) do |format|
      format.html { render :text => newsletter.email_body, :layout => newsletter.template }
    end

  end

end