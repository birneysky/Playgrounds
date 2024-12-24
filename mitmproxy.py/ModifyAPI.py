from mitmproxy import ctx, http
import json5
import json
import os

class ModifyHTTP:
    def __init__(self, api: str,  param_list: dict = None, json_file: str = None):
        self.api = api
        self.param_list = param_list
        self.json_file = json_file

    def response(self, flow: http.HTTPFlow):
        # 通过指定接口名称匹配请求链接
        if f"{self.api}" in flow.request.pretty_url:
            #ctx.log.info(f"Matching API: {self.api}")
            #ctx.log.info(flow.response.text)

            # 获取请求参数
            params = flow.request.query
            # 检查是否所有参数都满足（如果 param_list 指定）
            if self.param_list is None or all(self._compare_params(params.get(k), v) for k, v in self.param_list.items()):
                ctx.log.info("\033[34m" + f"Matching API: {self.api}" + "\033[0m")
                # 确定使用的 JSON 文件名
                json_file = self.json_file if self.json_file else f"{self.api}.json5"

                current_dir = os.path.dirname(os.path.abspath(__file__))
                config_path = os.path.join(current_dir, json_file)
                if os.path.exists(config_path):
                    with open(config_path, "r") as f:
                        config = json5.load(f)
                        #ctx.log.info(config)
                        flow.response.set_text(json.dumps(config))
                else:
                    ctx.log.warn(f"Config file for {self.api} not found: {config_path}")

    def _compare_params(self, param_value, expected_value):
        # 如果 param_value 是 None 则不匹配
        if param_value is None:
            return False
        
        # 将 param_value 转换为 expected_value 的类型后进行比较
        try:
            if isinstance(expected_value, int):
                return int(param_value) == expected_value
            elif isinstance(expected_value, float):
                return float(param_value) == expected_value
            else:
                return param_value == str(expected_value)
        except ValueError:
            return False 

addons = [
	ModifyHTTP(api="ac=membershipintro", param_list={"tab_type" : "vip"}),
    ModifyHTTP(api="gift.gift.getgiftlist", param_list={'tabid': 1, 'for_moment': 0}, json_file="ac=gift.gift.getgiftlisttabid1.json5"),
    ModifyHTTP(api="gift.giftpackage.getgiftpackageinfo"),
    ModifyHTTP(api="getgiftpackagehistory"),
    ModifyHTTP(api="pickgiftpackage"),
]