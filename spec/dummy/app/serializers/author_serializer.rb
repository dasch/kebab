class AuthorSerializer < Kebab::Serializer
  def name
    @author.name
  end
end
