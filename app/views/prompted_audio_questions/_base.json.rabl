attribute :id => :element_id
attributes :type, :title, :content, :created_at
child :prompt_audio, :root => "prompt_audio", if: :prompt_audio do
  attributes :full_url
end
