attribute :id => :element_id
attributes :type, :title, :content
child :prompt_audio, :root => "prompt_audio", if: :prompt_audio do
  attributes :full_url
end
child :response_audio, :root => "response_audio", if: :response_audio do
  attributes :full_url
end
