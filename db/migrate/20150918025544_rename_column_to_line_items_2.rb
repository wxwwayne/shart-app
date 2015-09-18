class RenameColumnToLineItems2 < ActiveRecord::Migration
  def change
  	rename_column :line_items, :quantity_of_items, :quantity
  end
end
