require './common'

def edit_field(html)
  doc = Nokogiri::HTML.parse(html)
  column_index, row_index = accept_field_designation
  unless row_index && column_index
    puts '時間割の指定に誤りがあります．もう一度入力してください．'
    return nil
  end

  child = Nokogiri::HTML::DocumentFragment.parse('')
  Nokogiri::HTML::Builder.with(child) do |td_node|
    td_node << "<td>#{create_class_field(accept_classdata)}</td>"
  end
  binding.pry
  doc.css('tr')[row_index].css('td')[column_index].replace(child)
  doc.to_html
end

def accept_field_designation
  print "何曜日？(#{col_headers[1..-1]}) >>"
  column = gets.strip
  column_index = col_headers.index(column)
  return nil unless column_index

  row_headers_shorten = row_headers.map { |r| r[0] }
  print "何時限目？(#{row_headers_shorten}) >>"
  row = gets.strip
  row_index = row_headers_shorten.index(row)
  return nil unless row_index

  row_index += 1 # 列ヘッダの分 +1 する．
  [column_index, row_index]
end

def edit_table(filename)
  html = File.open(filename).read
  if html.empty?
    puts '空のファイルです．'
    return nil
  end

  loop do
    table = edit_field(html)
    return table if quit_confirmation
  end
end

filename = accept_filename
edited_table = edit_table(filename)
if edited_table
  File.open(filename, 'w') do |f|
    f.puts edited_table if edited_table
  end
end
