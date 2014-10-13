require 'kebab/template_handler'
require 'kebab/template_resolver'

module Kebab
  class Railtie < Rails::Railtie
    initializer 'kebab.initialize_template_engine' do
      ActionView::Template.register_template_handler(:kebab, Kebab::TemplateHandler.new)
      ActionController::Base.append_view_path(Kebab::TemplateResolver.new)
    end
  end
end
