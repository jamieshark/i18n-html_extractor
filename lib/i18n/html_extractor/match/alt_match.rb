# frozen_string_literal: true

module I18n
  module HTMLExtractor
    module Match
      class AltMatch < BaseMatch
        def self.create(document, node)
          if node['alt'].present?
            [new(document, node, node['alt'])]
          else
            []
          end
        end

        def replace_text!
          key = SecureRandom.uuid
          document.erb_directives[key] = translation_key_object
          node['alt'] = "@@=#{key}@@"
        end
      end
    end
  end
end
