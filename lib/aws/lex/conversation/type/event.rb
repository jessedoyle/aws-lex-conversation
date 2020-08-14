# frozen_string_literal: true

module Aws
  module Lex
    class Conversation
      module Type
        class Event
          DEFAULT_AMBIGUITY_THRESHOLD = 0.5

          include Base

          required :alternative_intents, default: -> { [] }
          required :current_intent
          required :bot
          required :user_id
          required :input_transcript
          required :invocation_source
          required :output_dialog_mode
          required :message_version
          required :session_attributes
          required :recent_intent_summary_view
          optional :request_attributes
          optional :sentiment_response
          optional :kendra_response

          coerce(
            alternative_intents: Array[CurrentIntent],
            current_intent: CurrentIntent,
            bot: Bot,
            invocation_source: InvocationSource,
            output_dialog_mode: OutputDialogMode,
            session_attributes: symbolize_hash!,
            request_attributes: symbolize_hash!,
            recent_intent_summary_view: Array[RecentIntentSummaryView],
            sentiment_response: SentimentResponse
          )

          def ambiguous?(threshold: DEFAULT_AMBIGUITY_THRESHOLD)
            # NOTE: always returns false if NLU enhancements are not enabled
            candidate_intents(threshold: threshold).any?
          end

          def candidate_intents(threshold: DEFAULT_AMBIGUITY_THRESHOLD)
            candidates = alternative_intents.select do |intent|
              difference = current_intent.nlu_intent_confidence_score - intent.nlu_intent_confidence_score
              difference.abs <= threshold
            end
            candidates.sort_by(&:nlu_intent_confidence_score)
          end

          def confident?(threshold: DEFAULT_AMBIGUITY_THRESHOLD)
            !ambiguous?(threshold: threshold)
          end
        end
      end
    end
  end
end
