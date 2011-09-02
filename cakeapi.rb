require 'net/https'
require 'rubygems'
require 'json'
require 'CGI'

class CakeAPI
  
  def initialize(apikey)
      @key = apikey
  end
  
  def to_query(params, *parent)
      query = ''
      stack = ''
      parent = ''

      params.each do |k, v|
        if v.class == Hash
          parent = k
          stack = v
        else
          query << "#{CGI.escape(k)}=#{CGI.escape(v)}&"
        end
      end
      
      stack.each do |k,v|
        query << "#{CGI.escape(parent)}[#{CGI.escape(k)}]=#{CGI.escape(v)}&"
      end

      return query.chop! 
    end
  
  def call(url, params)
    uri = URI.parse('https://api.wbsrvc.com')

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    path = url[0,1] != '/' ? '/' + url : url

    headers = {'apikey' => @key}
    
    resp, data = http.post(path, to_query(params), headers)

    if data.include? 'error'
      return data
    end

    return JSON.parse(data)
  
  end
  
end
