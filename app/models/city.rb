class City < ActiveRecord::Base
  has_many :communes

  def to_param
    slug
  end

end
