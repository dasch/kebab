module Kebab
  class Serializer
    def initialize(context, arguments = {})
      @_context = context

      arguments.each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end

    def to_h
      serialized_attributes.each_with_object({}) do |attribute, h|
        h[attribute] = _read_attribute(attribute)
      end
    end

    def serialized_attributes
      methods - Serializer.instance_methods
    end

    def method_missing(name, *args, &block)
      @_context.send(name, *args, &block)
    end

    private

    def _read_attribute(attribute)
      value = public_send(attribute)

      if serializer_class = Kebab.serializer_class_for(value)
        serializer_class.new(@_context, attribute.to_s => value).to_h
      elsif value.is_a?(Array)
        value.map {|item|
          serializer_class = Kebab.serializer_class_for(item)
          serializer_class.new(@_context, attribute.to_s.singularize => item).to_h
        }
      else
        value
      end
    end
  end
end
