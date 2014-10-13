require 'spec_helper'
require 'kebab/serializer'

describe "serialization" do
  class CommentSerializer < Kebab::Serializer
    expects :comment

    def author
      @comment.author_name
    end

    def body
      @comment.body
    end
  end

  it "includes all public methods" do
    comment = double(:comment)
    serializer = CommentSerializer.new(comment: comment)

    comment.stub(:author_name) { "Alice" }
    comment.stub(:body) { "first post!" }

    expect(serializer.to_h).to eql({
      author: "Alice",
      body: "first post!"
    })
  end
end
