class AddEmailSentAtToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :email_sent_at, :datetime
  end
end
