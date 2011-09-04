#
class Cache
  
  def initialize
  end

  def self.get url, params
    if url
      id = self.key url
      begin
        pp "Cache valid"
        data = $cache.get id
      rescue Memcached::Error
        pp "Cache invalid"
        response = Net::HTTP.get(URI.parse("http://api.ihackernews.com/"+url.to_s))
        $cache.set id, response, 900000
        data = JSON.parse(response).to_json
      end
      callback = params.delete('callback')
      if callback
        data = "#{callback}(#{data})"
      end
      data
    else
      "No ID."
    end
  end

  def self.key url
    Digest::MD5.hexdigest(url)
  end

end