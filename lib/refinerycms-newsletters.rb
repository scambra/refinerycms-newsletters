require 'refinery'
module Refinery
  module Newsletters

    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.to_prepare do
        User.class_eval do
          devise :confirmable
          attr_accessible :confirmed_at
          scope :subscribed, where(User.arel_table[:confirmed_at].not_eq(nil)).where(:newsletter_subscribe => true) if User.arel_table[:confirmed_at]
          before_validation :skip_confirmation!, :unless => :confirmation_enabled?
          
          def enable_confirmation!
            @confirmation_enabled = true
          end
          def confirmation_enabled?
            @confirmation_enabled
          end
        end
      end
      
      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "newsletters"
          plugin.activity = {
            :class => Newsletter}
        end
      end
    end
  end
end
