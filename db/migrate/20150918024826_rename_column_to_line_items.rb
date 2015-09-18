class RenameColumnToLineItems < ActiveRecord::Migration
  def change
  	rename_column :line_items, :quantity, :quantity_of_items
  end
end
