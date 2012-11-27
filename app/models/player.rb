class Player < ActiveRecord::Base

  validates :name, :surname, :presence => true,   :length => {:minimum => 2}
  validates :email,          :uniqueness => true, :length => {:minimum => 4}


  # scopes and finders?
  # test them

end
