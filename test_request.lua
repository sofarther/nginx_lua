-- nginx 变量
local var = ngx.var
-- a b 为 自定义变量
ngx.say("ngx.var.a : ",var.a,"<br/>")
ngx.say("ngx.var.b : ",var.b, "<br/>")
-- nginx location 中 正则匹配到 的 对应的子分组 值
ngx.say("ngx.var[2] : ", var[2], "<br/>")

ngx.say("<br/>")

-- 请求头
-- 默认只 获取前 100， 可通过 ngx.req.get_headers(0) 获取全部

local headers = ngx.req.get_headers()
ngx.say("headers begin","<br/>")

ngx.say("Host: ",headers["Host"],"<br/>")
ngx.say("user-agent: ",headers["user-agent"],"<br/>")
-- 请求头中带有 中划线的参数，在使用属性形式访问时，则需要替换为下划线
-- 请求头 中 带有 下划线的参数 将无法 获取
-- 当 有多个值时，则 返回 table 类型
ngx.say("user-agent: ",headers.user_agent,"<br/>")
for k,v in pairs(headers) do
    if type(v) == "table" then
	    ngx.say(k," : ",table.concat(v,","),"<br/>")
    else
         ngx.say(k, ": ", v, "<br/>")
    end
end

ngx.say("headers end","<br/>")
ngx.say("<br/>")

--get 请求uri参数
ngx.say("uri args begin","<br/>")

local uri_args = ngx.req.get_uri_args()

for k,v in pairs(uri_args) do
    if type(v) == "table" then
        ngx.say(k, " : ",table.concat(v,","),"<br/>")
    else
        ngx.say(k," : ",v,"<br/>")
    end
end
ngx.say("uri args end","<br/>")

ngx.say("<br/>")

--post 参数
-- 需先调用 ngx.req.read_body() 读取 body 体
-- 或 在 nginx 配置文件中 使用 lua_need_request_body on; 开启读取body 体，不推荐
ngx.req.read_body()
ngx.say("post args begin","<br/>")

local post_args = ngx.req.get_post_args()

for k,v in pairs(post_args) do
    if type(v) == "table" then
        ngx.say(k, " : ",table.concat(v,","),"<br/>")
    else
        ngx.say(k," : ",v,"<br/>")
    end
end

ngx.say("post args end","<br/>")

ngx.say("<br/>")

-- 请求 http 协议
--输出
--  ngx.req.http_version: 1.1
--  ngx.req.get_method: POST
ngx.say("ngx.req.http_version: ",ngx.req.http_version(),"<br/>")
ngx.say("ngx.req.get_method: ",ngx.req.get_method(),"<br/>")
-- 获取 未解析 的请求头字符串
-- 输出：
-- 
--   POST /lua/1/2?a=34&b=45 HTTP/1.1
--Host: 192.168.1.190:8888
--Connection: keep-alive
--Content-Length: 71
--Cache-Control: max-age=0
--Origin: http://192.168.1.153
--Upgrade-Insecure-Requests: 1
--Content-Type: application/x-www-form-urlencoded
--User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36
--Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
--DNT: 1
--Referer: http://192.168.1.153/Demo/index
--Accept-Encoding: gzip, deflate
--Accept-Language: zh-CN,zh;q=0.9

ngx.say("ngx.req.raw_header :",ngx.req.raw_header(),"<br/>")
-- 输出：
--  denominator_stock_num=10&numerator_stock_num=6&cash=3&call_option_id=34
ngx.say("ngx.req.get_body_data : ",ngx.req.get_body_data(),"<br/>")
ngx.say("<br/>")
