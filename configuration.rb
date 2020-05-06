require 'json'
require 'optparse'
require './common'

def gets
  STDIN.gets
end

opt = OptionParser.new
opt_hash = JSON.parse(open('conf.json').read)

opt.on('-t', '--type TYPE', '時間割の種類(normal / zoom / four_links / custom)を指定．') do |param|
  if %w[normal zoom four_links].include? param
    opt_hash.merge!(type: param)
  else
    puts '-tオプションのパラメタが間違っています．'
    exit 1
  end
end

opt.on('-c', '--custom', '時間割の種類を自分で作成．') do
  customed_field = {}

  puts '時間割の種類を新しく作成します(項目の上限は10)．'
  10.times do |i|
    print '表示名を入力 >>'
    name = gets.strip
    print 'リンク有にしますか？(y / n) >>'
    link = gets.strip == 'y'

    customed_field.merge!(
      i.to_s.to_sym =>
      {
        name: name,
        link: link
      }
    )
    break if quit_confirmation
  end
  opt_hash.merge!(customed_field: customed_field)
end

opt.parse(ARGV)

File.open('conf.json', 'w') do |f|
  f.puts JSON.generate(opt_hash)
end
