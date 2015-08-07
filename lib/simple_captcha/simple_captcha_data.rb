module SimpleCaptcha
  class SimpleCaptchaData < ::ActiveRecord::Base

    self.table_name = "simple_captcha_data"

    class << self
      def get_data(key)
        data = where(key: key).first || new(key: key)
      end

      def remove_data(key)
        destroy_all(["#{connection.quote_column_name(:key)} = ?", key])
      end
    end
  end
end
