class Recording < ActiveRecord::Base
  RECORDING_TYPE_STANDARD = 'Standard'
  RECORDING_TYPE_PROMPT = 'Prompt'
  RECORDING_TYPE_RESPONSE = 'Response'
  
  #attr_accessible :title, :body, :recordable
  #attr_accessible :file
  has_attached_file :file
  belongs_to :recordable, polymorphic: true

  # Ensure appropriate lookup of LTI models
  def recordable_type=(sType)
     super(sType.to_s.classify.constantize.base_class.to_s)
  end

  validates_attachment :file, content_type: { content_type: ["audio/mpeg", "audio/wav"] }
end
