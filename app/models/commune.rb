class Commune < ActiveRecord::Base
  belongs_to :city

  def to_param
    slug
  end
end
