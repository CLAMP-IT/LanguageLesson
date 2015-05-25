class PromptedAudioQuestion < Question
  has_one :prompt_audio,
          -> { where(recording_type: Recording::RECORDING_TYPE_PROMPT) },
          class_name: 'Recording',
          as: :recordable,
          dependent: :destroy
end
