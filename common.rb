require 'json'
require 'nokogiri'
require 'pry'

def col_headers
  %w[時限 月 火 水 木 金]
end

def row_headers
  %w[1(9:00~10:30) 2(10:40~12:10) 3(13:00~14:30) 4(14:40~16:10) 5(16:15~17:45)]
end

def fetch_table_type
  json = open('conf.json').read
  type = JSON.parse(json)['type']

  if type == 'zoom'
    {
      url:  { name: 'ZoomURL', link: true },
      id:   { name: 'ZoomID', link: false },
      pass: { name: 'ZoomPass', link: false }
    }
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

    class_info = fetch_table_type
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

def accept_classdata
  print '授業名 >>'
  classdata = { name: gets.strip }

  table_types = fetch_table_type
  table_types.each do |key, value|
    print value[:name] + ' >>'
    classdata.merge!(key => gets.strip)
  end
  classdata
end
