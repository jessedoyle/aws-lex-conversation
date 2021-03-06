# frozen_string_literal: true

module Aws
  module Lex
    class Conversation
      module Type
        class SlotDetail
          include Base

          required :resolutions
          required :original_value

          coerce(
            resolutions: Array[SlotResolution]
          )
        end
      end
    end
  end
end
