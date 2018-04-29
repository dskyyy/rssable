require 'spec_helper'

describe RSSable::Detection::EngineDetector do
  describe '.call' do
    it 'returns :jekyll if given feed is generated by the Jekyll engine' do
      url = "http://blog.com/"
      urls = [
        "/feed.xml"
      ]

      expect(described_class.call(urls: urls, source_url: url)).to eq(["http://blog.com/feed.xml", :jekyll])
    end

    it 'returns :medium if given feed is generated by the Medium engine' do
      url = "http://blog.com"
      urls = [
        "http://medium.com/feed/nickname"
      ]

      expect(described_class.call(urls: urls, source_url: url)).to eq(["http://medium.com/feed/nickname", :medium])
    end

    it 'returns :wordpress if given feed is generated by the Wordpress engine' do
      url = "http://blog.com"
      urls = [
        "http://blog.com/comments/feed/",
        "http://blog.com/feed/"
      ]

      expect(described_class.call(urls: urls, source_url: url)).to eq(["http://blog.com/feed/", :wordpress])
    end

    it 'returns :blogger if given feed is generated by the Blogger engine' do
      url = "http://blog.com"
      urls = [
        "http://blog.com/feeds/posts/default",
        "http://blog.com/feeds/posts/default?alt=rss"
      ]

      expect(described_class.call(urls: urls, source_url: url)).to eq(["http://blog.com/feeds/posts/default?alt=rss", :blogger])
    end

    it 'returns :default if the feed engine is not detected' do
      url = "http://blog.com"
      urls = [
        "http://blog.com/custom-feed"
      ]

      expect(described_class.call(urls: urls, source_url: url)).to eq(["http://blog.com/custom-feed", :default])
    end

    it 'returns blank array if there is no feed URL given' do
      url = "http://blog.com"
      expect(described_class.call(urls: [], source_url: url)).to eq([])
    end
  end
end
