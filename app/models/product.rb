class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  acts_as_taggable_on :tags

  self.inheritance_column = :_type_disabled


  validates :sku, :name, :description, :buy_price, :sell_price, :stock,
            presence: true

  mount_uploader :photo_1, ProductPhotoUploader

  before_validation :set_defaults


  private

  def set_defaults
    self.stock ||= 0
    unless uuid
      begin
        self.uuid = SecureRandom.hex
      end while Product.exists?(uuid: uuid)
    end
  end
end
