## 环境安装
* Ruby

### 自动生成xxx.strings文件

* [creek](https://github.com/pythonicrubyist/creek.git)
```
sudo gem install creek
```
#### 修改配置
**在下面指定模块对应的前缀标识，以及默认的路径**
```
moduleTable = {"com.geolocation."=>"Geolocation","com.siri." => "Siri","com.noUpdate."=>"JsBridge","com.upgrade."=>"JsBridge","com.splash." => "Launch","com.camera."=>"Camera","com.video."=>"Video","com.widget."=>"Widget"}
otherStringFileName = "InfoPlist"
dirPath = "en-US.lproj"
```
**执行脚本**
```
ruby stringsFromExcel.rb
```

### 自动导出指定模块的多语言到Excel表格
* [writeexcel](https://github.com/cxn03651/writeexcel.git)
```
sudo gem install writeexcel
```
**修改配置指定导出模块和标题**

```
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
```
**执行脚本**
```
ruby strings2Excel.rb
```