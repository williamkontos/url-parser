class UrlParser 
  def initialize(new_url)
    @new_url = new_url
  end

  def scheme
    @new_url.split(":").first
  end

  def domain
    @new_url.split("//").last.split(":").first
  end

  def port
    port_included = @new_url.split("//").last.split("/").first.include?(":")
    port_parse = @new_url.split(":").last.split("/").first

    return port_included ? port_parse : "80" if self.scheme == "http"
    port_included ? port_parse : "443" if self.scheme == "https"
  end

  def path 
    path_included = @new_url.split("?").first[-1] != "/"
    path_parse = @new_url.split("/").last.split("?").first

    path_included ? path_parse : nil
  end

  def query_string
    q_hash = @new_url.split("?").last.split("#").first.gsub(/&|=| /, ' ')
    q_hash.split.each_slice(2).to_h
  end

  def fragment_id
    @new_url.split("#").last
  end
end

new_url = UrlParser.new "http://www.google.com:60/search?q=cat&name=Tim#img=FunnyCat"
no_path_url = UrlParser.new "https://www.google.com/?q=cat#img=FunnyCat"

insecure_url = UrlParser.new "http://www.google.com/search"

secure_url = UrlParser.new "https://www.google.com/search"

duplicate_param = UrlParser.new "http://www.google.com:60/search?q=cat&q=overwrite#img=FunnyCat"

p new_url.scheme
p new_url.domain
p new_url.port
p new_url.path
p new_url.query_string
p new_url.fragment_id

p no_path_url.path

p insecure_url.port

p secure_url.port

p duplicate_param.query_string
