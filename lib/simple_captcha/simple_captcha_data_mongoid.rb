module SimpleCaptcha
  class SimpleCaptchaData
    include Mongoid::Document
    include Mongoid::Timestamps

    field :key, type: String
    field :value, type: String

    class << self
      def get_data(key)
        where(:key => key).first || new(:key => key)
      end

      def remove_data(key)
        where(:key => key).delete_all
      end
    end
  end
end
