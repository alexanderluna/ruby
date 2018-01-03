require 'net/http'

url = URI('http://api.football-data.org/v1/competitions/455/leagueTable')
req = Net::HTTP::Get.new(url)
req['X-Auth-Token'] = '3b836df43b1d4b5faeb1ae7c3d96597f'
res = Net::HTTP.start(url.host, url.port) {|http| http.request(req)}
puts res.body
