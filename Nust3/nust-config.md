# Nust 服务器端配置 [官网](https://nuxt.com/docs/api/configuration/nuxt-config)

## 固定参数 `nuxt.config.ts`

```javascript
export default defineNuxtConfig({
  //调试工具
  devtools: { enabled: true },
  //服务器端渲染模式
  ssr: true,
});
```

## 调试工具

查看所有 router
![图 0](../images/2839313346567713267607b596ccdfd7faa84c05cd612784eac56dc8b250ecb3.png)

安装拓展

![图 2](../images/f7c4c00508e389600506778e7b7f7601aec328a078d2d844fa9323a0329ac8fb.png)

权限管理
![图 1](../images/e05f437e1e38cc3c339464be618d54cfbfd4ec070387348a7f723a909cdcc544.png)

## 预渲染 [文档](https://nuxt.com/docs/getting-started/prerendering)

```javascript
//nuxt.config.ts
export default defineNuxtConfig({
  nitro: {
    prerender: {
      //提前渲染 router 指定对象
      routes: ["/user/1", "/user/2"],
      //无视dynamic下所有组件
      ignore: ["/dynamic"],
    },
    //指定预渲染数据
    prerender 预渲染: {
      //控制开关
      crawlLinks: true,
      routes: ["/sitemap.xml", "/robots.txt"],
    },
  },
});
```
