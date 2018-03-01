class AddNameToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :name, :text
  end
end
