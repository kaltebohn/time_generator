require './common'

def create_table
  tabledata = accept_tabledata

  root = Nokogiri::HTML::DocumentFragment.parse('')
  Nokogiri::HTML::Builder.with(root) do |doc|
    doc.table border: 1 do
      doc.tr do # 曜日ヘッダーを生成．
        insert_col_headers!(doc)
      end
      row_headers.each do |header|
        classdata = tabledata.shift
        doc.tr do
          doc.td header
          classdata.each do |row|
            class_field = create_class_field(row)
            doc << "<td>#{class_field}</td>"
          end
        end
      end
    end
  end

  root
end

def insert_col_headers!(doc)
  col_headers.each do |header|
    doc.th header
  end
end

def accept_tabledata
  col_size = col_headers.length - 1
  row_size = row_headers
  tabledata = Array.new(row_size).map { Array.new(col_size, {}) }

  col_size.times do |i|
    puts "=====#{col_headers[i + 1]}曜日====="
    row_size.length.times do |j|
      puts "===#{j + 1}限==="
      tabledata[j][i] = accept_classdata # 時間割は列毎に入力するのが分かりやすいので転置の形に．
    end
  end
  tabledata
  #=> [[月1, 火1, 水1, ...], [月2, 火2, 水2, ...], ...]
end

filename = accept_filename(true) # ファイルの新規作成を許容．
File.open(filename, 'w') do |f|
  f.puts(create_table.to_html)
end
