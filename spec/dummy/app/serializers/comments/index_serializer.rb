class Comments::IndexSerializer < Kebab::Serializer
  attr_reader :comments, :page

  def next_page_url
    comments_path(page: @page + 1)
  end

  def prev_page_url
    comments_path(page: @page - 1)
  end
end
