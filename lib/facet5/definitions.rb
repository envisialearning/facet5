module Facet5
  class Definitions

    class << self
      def languages
        {
        "en" => "English", #English-US
        "en-us" => "USEnglish", #English-US
        "en-gb" => "English",
        "es" => "Spanish"
        }
      end

      def locales
        {
        "en" => "1033", #English-US
        "en-us" => "1033", #English-US
        "en-gb" => "2057",
        "es" => "1034"
        }.freeze
      end

      def timezones
        {
        "en" => "480", #English-US
        "en-us" => "480", #English-US
        "en-gb" => "0",
        "es" => "-60"
        }.freeze
      end
    end
  end

end