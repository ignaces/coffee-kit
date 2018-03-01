class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :email 
      t.string :town 
      t.string :selected_option
      t.timestamps
    end
  end
end
