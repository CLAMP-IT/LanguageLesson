class User < ActiveRecord::Base
  #attr_accessible :email, :moodle_id, :name
  validates_presence_of :email, :name

  belongs_to :institution
end
