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
end
