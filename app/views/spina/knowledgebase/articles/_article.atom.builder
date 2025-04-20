feed.entry(article, published: article.published_at, url: spina.knowledgebase_article_url(article)) do |entry|
  entry.title(article.title)
  entry.content(article.content, type: 'html')

  if article.user
    entry.author do |author|
      author.name(article.user.name)
    end
  end
end