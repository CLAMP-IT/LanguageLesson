class Recording < ActiveRecord::Base
  RECORDING_TYPE_STANDARD = 'Standard'
  RECORDING_TYPE_PROMPT = 'Prompt'
  RECORDING_TYPE_RESPONSE = 'Response'

  after_destroy :delete_file
  
  #attr_accessible :title, :body, :recordable
  #attr_accessible :file
  belongs_to :recordable, polymorphic: true

  # Ensure appropriate lookup of LTI models
  def recordable_type=(sType)
     super(sType.to_s.classify.constantize.base_class.to_s)
  end
  
  def full_url
    "#{S3_BUCKET.url}#{self.url}"
  end

  private
  def delete_file
      S3_BUCKET.objects[self.url].delete() if self.url
  end
end
