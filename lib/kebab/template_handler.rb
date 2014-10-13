module Kebab
  class TemplateHandler
    def call(template)
      path = template.virtual_path

      <<-RUBY
        serializer_class = Kebab.serializer_class_for_path(#{path.inspect})
        serializer = serializer_class.new(self, assigns.with_indifferent_access)

        data = serializer.to_h

        JSON.dump(data)
      RUBY
    end
  end
end
