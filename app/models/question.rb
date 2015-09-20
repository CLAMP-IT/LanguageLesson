class Question < ActiveRecord::Base
  include RankedModel
  ranks :row_order
  has_many :recordings, as: :recordable
  has_many :question_attempts
end
