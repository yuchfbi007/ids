# How to get started with IDS
```
export IDS_HOME=/path/to/ids  
$IDS_HOME/ids help  
```
# 需要配置的环境变量
IDS\_HOME=/path/to/ids (default:.)  
IDS\_AM\_HOST=/am/ip/address (default:127.0.0.1)  

# 配置注意事项
容器opendj的内网地址是`192.168.1.33`,选择“配置存储库”，如果选择容器opendj的地址时请填这个IP地址,端口号请填:`1389`  
详见docker-compose.yml文件和setup.properties文件  
