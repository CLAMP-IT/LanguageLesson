attribute :id => :element_id
attributes :type, :title, :content
child :recording, if: :recording do
  extends "recordings/_base"
end
