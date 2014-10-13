class CommentSerializer < Kebab::Serializer
  def author
    @comment.author
  end

  def body
    h @comment.body
  end

  def url
    url_for(@comment)
  end
end
