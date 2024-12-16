from mitmproxy import ctx, http
import json
import os

class Modify:
    def response(self, flow):
        #替换cookie，两种匹配请求链接的方式
        # if flow.request.host == "xxx.x.xxx.com.cn":
        if "ac=membershipintro" in flow.request.pretty_url:
            ctx.log.info("hahhha")
            ctx.log.info(flow.response.text)
            current_dir = os.path.dirname(os.path.abspath(__file__))
            with open(os.path.join(current_dir, "membershipintro.json"), "r") as f:
                config = json.load(f)
                ctx.log.info(config)
                flow.response.set_text(json.dumps(config))

addons = [
	Modify()
]