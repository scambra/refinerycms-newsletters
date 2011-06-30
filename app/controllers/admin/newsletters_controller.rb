module Admin
  class NewslettersController < Admin::BaseController
    crudify :newsletter
    
    def send_newsletter
      find_newsletter
      if request.post?
        if params[:email].present?
          NewsletterMailer.newsletter_email(params[:email], @newsletter).deliver
        elsif !@newsletter.sending?
          @newsletter.send!
        end
        unless from_dialog?
          redirect_to :action => 'index'
        else
          render :text => "<script>parent.window.location = '#{admin_newsletters_url}';</script>"
        end
      end
    end
  end
end