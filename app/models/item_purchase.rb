class ItemPurchase < ActiveRecord::Base
	attr_accessible :item_store_id, :price_per_unit, :purchase_id, :quantity, :status, :unit, :override_storage_location

    # Constants
    STATUSES = { 3 => 'just_bought_it', 
    			 2 => 'still_have_some',
    			 1 => 'running_low', 
    			 0 => 'almost_out' }


	# Relationships
	belongs_to :purchase
	belongs_to :item_store
	has_one :item, :through => :item_store


	# Scopes
	scope :by_quantity, order('quantity')
	scope :alphabetical, order('name')
	scope :by_status, order('status')

	# orders item_purchases by their purchase date
	scope :chronological, joins(:purchase).order('date')
	
	# retrieve items based on the passed in location value for their storage location
	scope :stored_in, lambda{|location| joins(:item).where('storage_location = ?', location)}
    
    # get items that have a given status
	scope :for_status, lambda { |status| where('status = ?', status) }
    
    # get all item_purchases for an item
    scope :for_item, lambda {|item_id| joins(:item_store).where('item_id = ?', item_id)}
   
    # returns all item_purchases belonging to a specific customer
    scope :for_customer, lambda {|customer_id| joins(:purchase).where('customer_id = ?', customer_id)}
  
    # returns all items belonging to a specific purchase
    scope :for_purchase, lambda {|purchase_id| where('purchase_id = ?', purchase_id)}


    # Methods
    # turn the numeric status into a human readable string
    def status_to_s
    	STATUSES[self.status].humanize
    end

    # get the name of the item by looking at the associated item record
    def name
    	self.item.name
    end

end
