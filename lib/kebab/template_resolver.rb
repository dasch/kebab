module Kebab
  class TemplateResolver < ActionView::Resolver
    def find_templates(name, prefix, partial = false, details = {})
      path = [prefix, name].compact.join("/")
      serializer_class = Kebab.serializer_class_for_path(path)

      if serializer_class.nil?
        []
      else
        template = build_template(serializer_class, path)
        [template]
      end
    end

    private

    def build_template(serializer_class, path)
      details = {
        virtual_path: path
      }

      # There's no need for a template source, all the code is in the
      # serializer.
      source = ""

      handler = ActionView::Template.handler_for_extension(:kebab)

      ActionView::Template.new(source, path, handler, details)
    end
  end
end
