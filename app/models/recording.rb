class Recording < ActiveRecord::Base
  #attr_accessible :title, :body, :recordable
  #attr_accessible :file
  has_attached_file :file
  belongs_to :recordable, polymorphic: true

  # Ensure appropriate lookup of LTI models
  def recordable_type=(sType)
     super(sType.to_s.classify.constantize.base_class.to_s)
  end
end
