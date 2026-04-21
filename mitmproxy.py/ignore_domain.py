from mitmproxy import ctx, http

def request(flow: http.HTTPFlow):
    # 定义要忽略的域名列表
    ctx.log.info("\033[34m" + f"request HOST: {flow.request.pretty_host}" + "\033[0m")
    
    # 检查请求域名是否在忽略列表中
    if flow.request.pretty_host in ignored_domains:
        flow.ignore = True  # 标记为忽略（不记录/显示）