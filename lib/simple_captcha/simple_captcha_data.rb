module SimpleCaptcha
  class SimpleCaptchaData < ::ActiveRecord::Base
    def self.rails3?
      ::ActiveRecord::VERSION::MAJOR == 3
    end

    if rails3?
      # Fixes deprecation warning in Rails 3.2:
      # DEPRECATION WARNING: Calling set_table_name is deprecated. Please use `self.table_name = 'the_name'` instead.
      self.table_name = "simple_captcha_data"
    else
      set_table_name "simple_captcha_data"
    end
    
    attr_accessible :key, :value
    before_destroy :remove_image

    def remove_image
      File.delete(Rails.root.to_s + '/public/captcha/' + key + '.jpg')
    end

    class << self
      def get_data(key)
        find_by_key(key) || new(:key => key)
      end

      def remove_data(key)
        destroy_all(["#{connection.quote_column_name(:key)} = ?", key])
      end
    end
  end
end
