require 'json'
require 'nokogiri'
require 'optparse'
require 'pry'

def col_headers
  %w[時限 月 火 水 木 金]
end

def row_headers
  %w[1(9:00~10:30) 2(10:40~12:10) 3(13:00~14:30) 4(14:40~16:10) 5(16:15~17:45)]
end

def table_type_from_conf
  json = open('conf.json').read
  conf = JSON.parse(json, symbolize_names: true)

  if conf[:type] == 'zoom'
    {
      url:  { name: 'ZoomURL', link: true },
      id:   { name: 'ZoomID', link: false },
      pass: { name: 'ZoomPass', link: false }
    }
  elsif conf[:type] == 'custom'
    conf[:customed_field]
  else
    {
      sylb: { name: 'シラバス', link: true },
      wbcl: { name: 'WebClass', link: true },
      othe: { name: '授業関連ページ', link: true }
    }
  end
end

def create_class_field(classdata)
  doc = Nokogiri::HTML::DocumentFragment.parse('')

  Nokogiri::HTML::Builder.with(doc) do |td_node|
    td_node.p classdata[:name].empty? ? "\s" : classdata[:name]
    td_node.br

    class_info = table_type_from_conf
    class_info.each do |key, value|
      if classdata[key].empty?
        td_node << "\s"
      elsif value[:link]
        td_node.a(value[:name], href: classdata[key])
      else
        td_node << classdata[key]
      end
      td_node.br
    end
  end
  doc #=> <p>化学概論</p><br><a href='sample.com'>シラバス</a><br> ... </a>
end

def accept_filename(allow_create = false)
  loop do
    print '出力したいファイル名 >>'
    filename = gets.strip
    return filename if File.exist?(filename) || allow_create

    puts 'ファイル名に誤りがあります．'
  end
end

def accept_classdata
  print '授業名 >>'
  classdata = { name: gets.strip }

  table_types = table_type_from_conf
  table_types.each do |key, value|
    print value[:name] + ' >>'
    classdata.merge!(key => gets.strip)
  end
  classdata
end

def confirm_quit
  loop do
    print '操作を終えますか？(y / n) >>'
    command = gets.strip
    return true if command == 'y'
    return false if command == 'n'
  end
end
