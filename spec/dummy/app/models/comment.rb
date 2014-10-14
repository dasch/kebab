require 'active_model'

class Comment
  extend ActiveModel::Naming

  def self.first
    all.first
  end

  def self.all
    [
      new(body: "first post!", author: Author.new(name: "Alice")),
      new(body: "<b>dammit!</b>", author: Author.new(name: "Bob")),
    ]
  end

  attr_reader :body, :author

  def initialize(body:, author:)
    @body, @author = body, author
  end

  def to_param
    "42"
  end
end
