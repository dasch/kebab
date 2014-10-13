module Kebab
  class Serializer
    def initialize(arguments = {})
      arguments.each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end

    def to_h
      attributes = methods - Serializer.instance_methods
      attributes.each_with_object({}) do |method, h|
        h[method] = public_send(method)
      end
    end

    def self.expects(*argument_names)
      
    end
  end
end
