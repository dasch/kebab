describe "simple rendering", type: :request do
  example "rendering with a serializer" do
    get '/comments/42.json'
    expect(response.status).to eql(200)

    expect(JSON.parse(response.body)).to eql({
      "comment" => {
        "body" => "first post!",
        "author" => {
          "name" => "Alice"
        },
        "url" => "/comments/42"
      }
    })
  end

  example "rendering a list of objects" do
    get '/comments.json', page: 3
    expect(response.status).to eql(200)

    expect(JSON.parse(response.body)).to eql({
      "comments" => [
        {
          "body" => "first post!",
          "author" => {
            "name" => "Alice"
          },
          "url" => "/comments/42"
        },
        {
          "body" => "&lt;b&gt;dammit!&lt;/b&gt;",
          "author" => {
            "name" => "Bob"
          },
          "url" => "/comments/42"
        }
      ],
      "page" => 3,
      "next_page_url" => "/comments?page=4",
      "prev_page_url" => "/comments?page=2"
    })
  end
end
