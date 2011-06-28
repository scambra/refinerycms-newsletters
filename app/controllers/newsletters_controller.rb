class NewslettersController < ApplicationController

  def show
    @newsletter = Newsletter.find(params[:id])

    render :text => @newsletter.email_body, :layout => @newsletter.template
  end

  def unsubscribe

    user_email = params[:email]
    unless user_email.blank?
      user = User.find_by_email(user_email)
      unless user.nil?
        user.newsletter_subscribe = false
        user.save
        # lets just increase unsubscribed field for the last newsletter (we SUM for all of them to get statistic)
        # later if needed we can add statistic for particular newsletter by adding newsletter id to url
        news_letter = Newsletter.last
        unsubscribed = news_letter.unsubscribed
        unless unsubscribed.blank?
          unsubscribed = unsubscribed + 1
          news_letter.unsubscribed = unsubscribed
        else
          news_letter.unsubscribed = 1
        end
        news_letter.save
      end
    end

  end

end
