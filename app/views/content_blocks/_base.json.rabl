attribute :id => :element_id
attributes :type, :title, :content
child :recording, if: :recording do
  attributes :full_url
end
