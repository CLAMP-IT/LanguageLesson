class Activity < ActiveRecord::Base
  belongs_to :course

  belongs_to :doable, polymorphic: true
end
