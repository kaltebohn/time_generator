require 'nokogiri'
require 'pry'

def create_table
  column_headers = %w[時限 月 火 水 木 金]
  row_headers = %w[1(9:00~10:30) 2(10:40~12:10) 3(13:00~14:30) 4(14:40~16:10) 5(16:15~17:45)]
  classdata = accept_classdata

  root = Nokogiri::HTML::DocumentFragment.parse('')
  Nokogiri::HTML::Builder.with(root) do |doc|
    doc.table border: 1 do
      doc.tr do # ヘッダー
        column_headers.each do |header|
          doc.th header
        end
      end
      row_headers.each do |header| # 各曜日
        daily_data = classdata.shift
        doc.tr do
          doc.td header
          5.times do |i|
            child = Nokogiri::HTML::DocumentFragment.parse('')
            Nokogiri::HTML::Builder.with(child) do |td_node|
              next if daily_data[i][:name].empty?

              td_node.p daily_data[i][:name]
              td_node.a 'シラバス', href: daily_data[i][:sylb]
              td_node.br
              td_node.a 'WebClass', href: daily_data[i][:wbcl]
              td_node.br
              td_node.a '授業関連ページ', href: daily_data[i][:othe]
            end
            doc << "<td>#{child.to_html}</td>"
          end
        end
      end
    end
  end

  root
end

def accept_classdata
  column_headers = %w[月 火 水 木 金]
  classdata = Array.new(5).map { Array.new(5, {}) }

  5.times do |i|
    puts "=====#{column_headers[i]}曜日======"
    5.times do |j|
      class_obj = {}
      print '授業名 >>'
      class_obj.merge!(name: gets.strip)
      print 'シラバスURL >>'
      class_obj.merge!(sylb: gets.strip)
      print 'webclassURL >>'
      class_obj.merge!(wbcl: gets.strip)
      print 'その他授業URL >>'
      class_obj.merge!(othe: gets.strip)

      classdata[j][i] = class_obj # 時間割は列毎に入力するのが分かりやすいので転置の形に．
    end
  end
  classdata
end

File.open('time_table.html', 'w') do |f|
  f.puts(create_table.to_html)
end
