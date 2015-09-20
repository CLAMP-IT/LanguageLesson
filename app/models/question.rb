class Question < ActiveRecord::Base
  include RankedModel
  ranks :row_order
  has_many :recordings, as: :recordable
end
