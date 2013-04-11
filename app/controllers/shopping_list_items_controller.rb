class ShoppingListItemsController < ApplicationController
  # user must be logged in to get to inventory info
  authorize_resource!
	
  def index
	@shopping_list_items = ShoppingListItem.all
  end

  def new
    @shopping_list_item = ShoppingListItem.new
  end

  def edit
    @shopping_list_item = ShoppingListItem.find(params[:id])
  end

  def create
    @shopping_list_item = ShoppingListItem.new(params[:shopping_list_item])
    if @shopping_list_item.save
      # if saved to database
      flash[:notice] = "Successfully created #{@shopping_list_item.item.name}."
      redirect_to @shopping_list_item # go to show shopping_list_item page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @shopping_list_item = ShoppingListItem.find(params[:id])
    authorize! :update, @shopping_list_item
    if @shopping_list_item.update_attributes(params[:shopping_list_item])
      flash[:notice] = "Successfully updated #{@shopping_list_item.item.name}."
      redirect_to @shopping_list_item
    else
      render :action => 'edit'
    end
  end

  def destroy
    @shopping_list_item = ShoppingListItem.find(params[:id])
    @shopping_list_item.destroy
    flash[:notice] = "Successfully removed #{@shopping_list_item.item.name} from your list."
    redirect_to shopping_list_items_url
  end
end