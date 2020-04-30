require 'nokogiri'
require 'pry'

def edit_table(html)
  doc = Nokogiri::HTML.parse(html)

  row_index, column_index = accept_field_designation
  unless row_index && column_index
    print '時間割の指定に誤りがあります．'
    return nil
  end

  target_node = doc.css('tr')[row_index + 1].css('td')[column_index + 1]
  print target_node
end

def accept_field_designation
  print '何曜日？(月 火 水 木 金) >>'
  column = gets.strip
  column_index = %w[月 火 水 木 金].index(column)
  return nil unless column_index

  print '何時限目？(1 2 3 4 5) >>'
  row = gets.strip
  row_index = %w[1 2 3 4 5].index(row)
  return nil unless row_index

  [column_index, row_index]
end

html = open('time_table.html').read
p edit_table(html)
