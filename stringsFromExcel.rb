require 'creek'
creek = Creek::Book.new './iOS.xlsx'

sheet = creek.sheets[0]
#配置表
moduleTable = {"com.geolocation."=>"Geolocation","com.siri." => "Siri","com.noUpdate."=>"JsBridge","com.upgrade."=>"JsBridge","com.splash." => "Launch","com.camera."=>"Camera","com.video."=>"Video","com.widget."=>"Widget"}
otherStringFileName = "InfoPlist"
dirPath = "en-US.lproj"
sheet.rows.each_with_index do |row,idx|
    if row.empty?
        p "row is empty #{idx}"
        next
    end
    key = row.values.first
    string = row.values.last
    p "ready to write #{string}"
    if idx == 0
        dirPath = "#{string.sub("_", "-")}.lproj"
        if !Dir.exist?(dirPath)
            Dir.mkdir(dirPath)
        end
    else
        fileName = otherStringFileName
        moduleTable.each do |k,v|
            if key.include?(k)
                fileName = v
            end
        end
        filePath = "#{dirPath}/#{fileName}.strings"
        file = File.open(filePath,"a")
        file.puts "\"#{key}\" = \"#{string}\";"
        file.close
        p "write #{string} in #{filePath}"
    end
end