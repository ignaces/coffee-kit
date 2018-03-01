class Subscription < ActiveRecord::Base
  enum status: [:pending, :active, :expired]

  belongs_to :user
  belongs_to :order
  belongs_to :subscription_plan
  has_many :subscription_months, dependent: :destroy

  before_create :set_defaults

  private

  def set_defaults
    self.status = Subscription.statuses[:pending] unless self.status
  end

end
