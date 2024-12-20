from mitmproxy import ctx, http
import json
import os

class Modify:
    def __init__(self, api: str):
        self.api = api

    def response(self, flow: http.HTTPFlow):
        # 通过指定接口名称匹配请求链接
        if f"{self.api}" in flow.request.pretty_url:
            #ctx.log.info(f"Matching API: {self.api}")
            print("\033[34m" + f"Matching API: {self.api}" + "\033[0m")
            #ctx.log.info(flow.response.text)
            current_dir = os.path.dirname(os.path.abspath(__file__))
            config_path = os.path.join(current_dir, f"{self.api}.json")
            if os.path.exists(config_path):
                with open(config_path, "r") as f:
                    config = json.load(f)
                    #ctx.log.info(config)
                    flow.response.set_text(json.dumps(config))
            else:
                ctx.log.warn(f"Config file for {self.api} not found: {config_path}")    
addons = [
	Modify(api="ac=membershipintro")
]