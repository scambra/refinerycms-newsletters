class AddNewsletterSubscribeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :newsletter_subscribe, :boolean
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
  end

  def self.down
    remove_column :users, :confirmation_sent_at
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_token
    remove_column :users, :newsletter_subscribe
  end
end
