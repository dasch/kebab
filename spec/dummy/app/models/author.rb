require 'active_model'

class Author
  extend ActiveModel::Naming

  attr_reader :name

  def initialize(name:)
    @name = name
  end
end
