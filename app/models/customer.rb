class Customer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :phone, :street, :zip, :user_id  

  # Relationships 
  has_many :memberships
  has_many :purchases
  has_many :shopping_list_items
  belongs_to :user
  
  # Scopes
  scope :alphabetical, order('last_name, first_name')
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
  scope :for_user, lambda{|user_id| where('user_id = ?', user_id)}
  
  # Other methods
  def name
    "#{last_name}, #{first_name}"
  end
  
  def proper_name
    "#{first_name} #{last_name}"
  end

  def memberships
    return Membership.where('customer_id = ?', id)
  end
 
 #### TODO: need to figure out the parameter diff between allow_blank and validates_presence_of
 
  # Validations 
  validates_presence_of :first_name, :last_name, :street, :phone, :zip
  validates_format_of :phone, :with => /^(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})$/, :message => "should be 10 digits (area code needed) and delimited with dashes only", :allow_blank => false
  # validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format", :allow_blank => false
  validates_format_of :zip, :with => /^\d{5}$/, :message => "should be five digits long", :allow_blank => false
  
end

