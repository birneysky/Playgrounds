### NAT 类型

#### 完全锥形NAT
![full cone](./images/full_cone.png)

### NAT  穿越原理
```
假设C1 和 C2 进行互通

c1 和 c2 互通的前提是 c1 要知道 c2的地址，c2 要知道 c1 的地址

为了知道地址信息， c1 和 c2 需要向 STUN 服务发送消息，

STUN 服务收到请求后，就知道了 c1 c2 的公网 ip 地址和端口

然后将c1 的 ip 和 端口 与c2 交换

```
