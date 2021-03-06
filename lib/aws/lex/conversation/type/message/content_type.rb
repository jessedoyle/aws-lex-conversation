# frozen_string_literal: true

module Aws
  module Lex
    class Conversation
      module Type
        class Message
          class ContentType
            include Enumeration

            enumeration('PlainText')
            enumeration('SSML')
            enumeration('CustomPayload')
          end
        end
      end
    end
  end
end
