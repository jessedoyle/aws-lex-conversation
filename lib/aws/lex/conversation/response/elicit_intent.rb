# frozen_string_literal: true

module Aws
  module Lex
    class Conversation
      module Response
        class ElicitIntent < Base
          attr_accessor :message, :response_card

          def initialize(opts = {})
            super
            self.message = opts[:message]
            self.response_card = opts[:response_card]
          end

          def dialog_action
            {
              type: 'ElicitIntent',
              message: message,
              responseCard: response_card
            }.reject { |_, v| v.nil? }
          end
        end
      end
    end
  end
end
