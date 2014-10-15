Kebab
=====

A simple and straightforward way to serialize Ruby objects to JSON. The only thing you need to do is to add a _serializer class_ (more on that in a bit) that matches a model, and voilá!, you too can serialize JSON!

Let's start with the basics, though. Imagine a set of Active Record models that looks like this:

```ruby
class Post < ActiveRecord::Base
  belongs_to :author
  has_many :comments
  
  validates_presence_of :title, :body
end

class Author < ActiveRecord::Base
  validates_presence_of :name
end

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author
  
  validates_presence_of :body
end
```

So here's the controller you'd write in order to list and show posts if you wanted to render HTML using ERb:

```ruby
class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end
end
```

However, we'd like to add a JSON API as well, preferably looking something like this:

```js
// /posts.json
{
  "posts": [
    {
      "title": "...",
      "body": "...",
      "author": { "name": "..." },
      "comments": [
        {
          "author": { "name": "..." },
          "body": "..."
        }
      ]
    }
  ]
}

// /posts/42.json
{
  "post": {
    "title": "...",
    "body": "...",
    "author": { "name": "..." },
    "comments": [
      {
        "author": { "name": "..." },
        "body": "..."
      }
    ]
  }
}
```

In order to add support for JSON rendering to this controller, you have to do three things. Nah, I'm kidding, you don't have to change the controller at all! Wohoo!

Instead, you add these cute little classes to `app/serializers/`:

```ruby
# app/serializers/posts/index_serializer.rb
class Posts::IndexSerializer < Kebab::Serializer
  def posts
    @posts
  end
end

# app/serializers/posts/show_serializer.rb
class Posts::ShowSerializer < Kebab::Serializer
  def post
    @post
  end
end

# app/serializers/post_serializer.rb
class PostSerializer < Kebab::Serializer
  def title
    @post.title
  end
  
  def body
    @post.body
  end
  
  def author
    @post.author
  end
  
  def comments
    @post.comments
  end
end

# app/serializers/comment_serializer.rb
class CommentSerializer < Kebab::Serializer
  def body
    @post.body
  end
  
  def author
    @post.author
  end
end

# app/serializers/author_serializer.rb
class AuthorSerializer < Kebab::Serializer
  def name
    @author.name
  end
end
```

Wow, there's a lot of stuff going on here! Actually, it's pretty simple: when rendering the JSON response for the `index` action in `PostsController`, `Posts::IndexSerializer` is used. Because you assigned `@posts`, that instance variable will be available in the serializer instance. Each public method in a serializer corresponds to an attribute in the resulting JSON, and its return value will itself be serialized and used as the value. This means that returning an array of `Post` instances will result in each post being serialized – but how does that work? Well, convention triumphs again: `PostSerializer` will be used! This process will be repeated until all the objects have been serialized.
