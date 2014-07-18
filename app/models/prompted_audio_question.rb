class PromptedAudioQuestion < Question
  has_one :recording, as: :recordable, dependent: :destroy
end
