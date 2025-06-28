# HTML5 系统消息推送 [官方文档](https://developer.mozilla.org/zh-CN/docs/Web/API/Notifications_API)

## 在 electron 环境中 HTML5 系统消息推送 略过授权管理

```javascript
add.addEventListener("click", () => {
  // shell.openExternal("https://www.nuxtjs.cn/");
  const msg = {
    title: "51在线",
    body: "点我在线查看谛听可爱录像",
    icon: "../earth.ico",
  };
  const send = new window.Notification(msg.title, msg);
});
```
