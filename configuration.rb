require 'json'
require 'optparse'

opt = OptionParser.new
conf_hash = {}

opt.on('-t', '--type TYPE', '時間割の種類(normal / zoom)') do |param|
  if %w[normal zoom].include? param
    conf_hash.merge!(type: param)
  else
    puts 'タイプオプションのパラメタが間違っています．'
  end
end
opt.parse(ARGV)

File.open('conf.json', 'w') do |f|
  f.puts JSON.generate(conf_hash)
end
