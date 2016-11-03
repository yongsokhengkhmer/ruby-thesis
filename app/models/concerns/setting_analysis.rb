module SettingAnalysis
  extend ActiveSupport::Concern

  included do
    settings analysis: {
      tokenizer: {
        custom_tokenizer: {
          type: "nGram",
          token_chars: %w(letter digit whitespace punctuation symbol)
        }
      },
      analyzer: {
        custom_analyzer: {
          type: "custom",
          tokenizer: "custom_tokenizer",
          filter: "lowercase"
        }
      }
    }
  end
end
