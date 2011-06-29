class CreateNewsletters < ActiveRecord::Migration

  def self.up
    create_table :newsletters do |t|
      t.string :title
      t.string :template
      t.text :email_body
      t.integer :emails_sent
      t.integer :unsubscribed
      t.integer :number
      t.string :status

      t.timestamps
    end

    add_index :newsletters, :id
    add_index :newsletters, [:template, :number]

    load(Rails.root.join('db', 'seeds', 'newsletters.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "newsletters"})

    drop_table :newsletters
  end

end
