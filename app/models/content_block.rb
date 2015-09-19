class ContentBlock < ActiveRecord::Base
  has_one :lesson_element, as: :presentable
  has_one :recording, -> { where(recording_type: Recording::RECORDING_TYPE_STANDARD) }, as: :recordable, dependent: :destroy

  def type
    "ContentBlock"
  end
end
