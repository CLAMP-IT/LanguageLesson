class PromptResponseAudioQuestion < Question
  has_one :prompt_audio,
          -> { where(recording_type: Recording::RECORDING_TYPE_PROMPT) },
          class_name: 'Recording',
          as: :recordable,
          dependent: :destroy
  has_one :response_audio,
          -> { where(recording_type: Recording::RECORDING_TYPE_RESPONSE) },
          class_name: 'Recording',
          as: :recordable,
          dependent: :destroy
end
