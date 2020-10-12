require 'writeexcel'

# Create a new Excel Workbook
if File.exist?('template.xlsx')
    File.delete('template.xlsx')
end

workbook = WriteExcel.new('template.xlsx')

# Add worksheet(s)
worksheet  = workbook.add_worksheet

# Add and define a format
format = workbook.add_format
format.set_bold
format.set_color('red')
format.set_align('left')
index = 0

exportModules = [
    "Widget","Video",
    "Siri",
    "Launch",
    "JsBridge",
    "InfoPlist",
    "Geolocation",
    "Camera"
]
writeStrings = [{"key"=>"zh-CN"}] #标题
 #写入标题
writeStrings.each do |string|
    string.each do |k,v|
        worksheet.write(index,0,k,format)
        worksheet.write(index,1,v,format)
        index+=1
    end
end
exportModules.each do |fileName|
    file = File.open("./sample.lproj/#{fileName}.strings","r")
    worksheet.write(index,0,"") #写入空行
    worksheet.write(index,1,"")
    index+=1
    file.each_line do |line|
        p "原始：#{line}"
        table = line.split('=')
        if table.empty?
            next
        end
        key = ""
        val = ""
        key = table.first
        if table.size != 2
            val = table[1, table.size].join("=")
        else
            val = table.last
        end
        p "key:#{key.to_s} => val:#{val.to_s}"
        val = val.chomp #除去分隔符
        val = val.strip #移除前后的空格
        val = val.chop #除去最后一个字符“;”
        key = key.strip #移除前后的空格
        p "key2:#{key.to_s} => val2:#{val.to_s}"
        if key[0] == '"' && key[key.length-1] == '"'
            key = key[1,key.length-2] #移除前后的双引号
        end
        if val[0] == '"' && val[val.length-1] == '"'
            val = val[1,val.length-2]            #移除前后的双引号
        end
        p "key3:#{key.to_s} => val3:#{val.to_s}"
        worksheet.write(index,0,key)
        worksheet.write(index,1,val)
        index = index + 1

    end
end
workbook.close
p "done"