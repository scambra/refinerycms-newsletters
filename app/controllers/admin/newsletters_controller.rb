module Admin
  class NewslettersController < Admin::BaseController
    crudify :newsletter
    
    def send_newsletter
      find_newsletter
      if request.post?
        if params[:email]
          NewsletterMailer.newsletter_email(params[:email], @newsletter).deliver
        elsif @newsletter.status.nil?
          @newsletter.update_attribute :status, 'sending'
          # this actually should be a delayed job, but as far as client do not expect a huge amount of subscribers
          # and don't want to pay additional cost for Worker on Heroku we will leave it like this for now
          send_to_all(@newsletter)
        end
        unless from_dialog?
          redirect_to :action => 'index'
        else
          render :text => "<script>parent.window.location = '#{admin_newsletters_url}';</script>"
        end
      end
    end

    protected
    include ::Refinery::Newsletters::SendNewsletter
  end
end