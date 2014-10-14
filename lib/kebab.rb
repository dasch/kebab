module Kebab
  class << self
    def serializer_class_for_path(path)
      "#{path}_serializer".camelize.constantize
    rescue NameError
      nil
    end

    def serializer_class_for(object)
      "#{object.class}Serializer".constantize
    rescue NameError
      nil
    end
  end
end

require 'kebab/serializer'
require 'kebab/railtie'
