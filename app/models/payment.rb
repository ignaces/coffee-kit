class Payment < ActiveRecord::Base
  enum status: [:pending, :completed, :canceled, :failed]

  belongs_to :order

  before_create :set_defaults

  def complete!
    unless completed?
      ActiveRecord::Base.transaction do 
        update_attributes status: Payment.statuses[:completed], completed_at: Time.now
        order.complete!
      end
    end
  end

  def fail!
    unless failed?
      update_attribute :status, Payment.statuses[:failed]
      order.fail!
    end
  end

  private

  def set_defaults
    self.status = Payment.statuses[:pending]
  end

end
