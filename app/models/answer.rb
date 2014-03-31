class Answer < ActiveRecord::Base
  belongs_to :question
  #attr_accessible :title, :content
end
