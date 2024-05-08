# bootstrap && jquery

```
<script src="../bootstrap/jquery-3.7.1.min.js"></script>

<script src="../bootstrap/bootstrap-5.3.0-alpha1-dist/js/bootstrap.bundle.js"></script>
```

1. 这是一个常用的初始化模板，用于引入一些外部的样式表和脚本文件，以及设置一些基本的样式和功能
1. `<link>`标签用于链接外部的样式表文件，`href`属性指定文件的路径，`rel`属性指定文件的关系
1. `<script>`标签用于引入外部的脚本文件，`src`属性指定文件的路径
1. `../`表示从当前文件夹的上一级文件夹中找，`./`表示从当前文件夹中找
1. `normalize.css`是一个常用的重置样式表，用于消除不同浏览器之间的默认样式差异
1. `bootstrap.css`和`bootstrap.bundle.js`是 bootstrap 框架提供的核心样式表和脚本文件，用于实现各种组件和功能
1. `bootstrap-icons.css`是 bootstrap 框架提供的图标样式表，用于显示各种图标
1. `jquery-3.7.1.min.js`是 jQuery 库提供的压缩版脚本文件，用于简化 JavaScript 编程
1. `less_demo.css`和`less_demo.less`是使用 less 预处理器编写的样式表文件，用于扩展 CSS 的功能
1. `font.css`和`MiSans-Normal.ttf`是自定义的字体样式表和字体文件，用于显示特定的字体

---

## 栏栅排版 [详见](https://v5.bootcss.com/docs/layout/grid/)

1. `row/col 1. ||lg/md/sm|| 1. 1/12` 最大 12 格否则换行,自行计算大小占比，表示使用 row 和 col 类名创建一个栅格容器和栅格列，后面跟着屏幕尺寸和栅格数来指定不同设备下的布局，最多可以分成 12 个栅格，超过则换行
1. 想要高也自动布局-将父级设置 `flex` 并且让其自持换行 `wrap`,再将子级给满 `son-lg/md-12`，表示使用 `flex` 类名让父元素成为一个弹性盒子，并使用 `flex-wrap` 类名让子元素可以换行，然后使用 `son-lg/md-12` 类名让子元素在大屏幕或中等屏幕下占满 12 个栅格

1. `<pre></pre>` --这个标签中装代码子级的`<>`为`&lt;&gt;`
1. `<kbd> Ctrl </kbd>` --这个标签是用于查看键盘快捷键

---

## Text [详见](https://v5.bootcss.com/docs/utilities/text/)

1. `user-select-all/auto/none` --用户单机后全部/智能/无法选择

1. `text-||lg/md/sm|| - start/center/end` --设置文字对齐方式
1. `text-nowrap` --不换行

1. `fs-1/2/3/4/5/6/7` -- 文字大小
1. `fs-bold/bolder/semibold/medium/normal/light/lighter` --文字粗细
1. `fst-italic/normal` --文字倾斜

1. `lh- 1 / sm / base / lg` --根据大小修改行高 默认/小/中/大 是英文没错

1. `font-monospace` --使文字等宽

1. `text-reset` -- 使文字颜色跟随父级

1. `text-break` -- 为防止文字太多超出父级，添加的自动换行
1. `text-truncate` --文本太多自动变为省略号

1. `text-lowercase/uppercase/capitalize` --智能文本转换 小写/大写/首字母大写

1. `text-decoration-underline` --文字下边线
1. `text-decoration-line-through` --文字删除线
1. `text-decoration-none` -- 移除线效果

1. `card-header/title/body/footer` --设置页眉 页脚 ; [详见](https://v5.bootcss.com/docs/5.3/components/card/#header-and-footer)

### 文字颜色 [详见](https://v5.bootcss.com/docs/utilities/colors/)

1. text-primary 蓝
1. text-primary-emphasis 淡蓝
1. text-secondary 灰
1. text-secondary-emphasis 白灰
1. text-success 绿
1. text-success-emphasis 淡绿
1. text-danger 红
1. text-danger-emphasis 淡红
1. text-warning 黄
1. text-warning-emphasis 淡红
1. text-info 青
1. text-info-emphasis 淡青
1. text-light 白
1. text-light-emphasis 浅白
1. text-dark 黑
1. text-dark-emphasis 一等黑
1. text-body 二等黑
1. text-muted 三等黑
1. text-body-emphasis 白
1. text-body-secondary 一等灰
1. text-body-tertiary 二等灰
1. text-black 黑
1. text-white 白
1. text-black-50 黑 50 透明
1. text-white-50 白 50 透明

> `text-opacity-||lg/md/sm|| - 75/50/25` --设置透明

> `--bs-gray-100/900` color 中设置灰阶

---

## Block [详见](https://v5.bootcss.com/docs/utilities/spacing/)

1. `vr` -- 水平分割线 就像 hr 一样 ;!重要

1. `z-n1/0/3` 添加 z-index 层级 n1 为-1

1. `visible/invisible` --使元素显示/隐藏

1. `clearfix` -- 清理浮动

1. `float-start/end/none` --设置浮动效果

1. `opacity-100/75/50/25` --设置盒子透明度

1. `pre-scrollable` --当超过一定高度时显示滚动条

1. `shadow/shadow-none/sm/lg/inset` --设置盒子阴影 inset 为内阴影 shadow 默认 sm 少 lg 大

1. `object-fit - ||lg/sm/md|| - contain/cover/fill/scale/none` --设置图片填充方式

1. `overflow-auto/hidden/visible/scroll` --设置 overflow 属性

1. `align-baseline/top/middle/bottom/text-top/text-bottom` --垂直对齐

## Border [详见](https://v5.bootcss.com/docs/utilities/borders/)

1. `border-||top/end/bottom/start||` --设置边框

1. `border-||top/end/bottom/start|| -1/5` --设置边框大小

1. `border-||text-color||` --设置边框颜色

1. `border-opacity-10/25/50/75/100` --设置透明度

1. `rounded -||top/end/bottom/start||` --设置圆角
1. `rounded-0/5/circle/pill` --设置圆角大小 自动调整大小 rem 随分辨率调整 circle 为 50% pill 为 50rem

### Border-color [详见](https://v5.bootcss.com/docs/utilities/colors/)

1. border-primary 青
1. border-primary-subtle 淡青
1. border-secondary 灰
1. border-secondary-subtle 浅灰
1. border-success 绿
1. border-success-subtle 浅绿
1. border-danger 红
1. border-danger-subtle 浅红
1. border-warning 黄
1. border-warning-subtle 浅黄
1. border-info 蓝
1. border-info-subtle 浅蓝
1. border-light 亮白
1. border-light-subtle 淡白
1. border-dark 黑
1. border-dark-subtle 淡黑
1. border-white 白

## 背景

`bg-gradient` --添加渐变 原理是纯黑 15%到 0 的渐变 效果不好

`bg-opacity-10/25/50/75/100` --设置背景透明度

### Background-color [详见](https://v5.bootcss.com/docs/utilities/colors/)

1. bg-primary 蓝
1. bg-primary-subtle 暗蓝
1. bg-secondary 灰
1. bg-secondary-subtle 深灰
1. bg-success 绿
1. bg-success-subtle 暗绿
1. bg-danger 红
1. bg-danger-subtle 深红
1. bg-warning 黄
1. bg-warning-subtle 暗黄
1. bg-info 青
1. bg-info-subtle 暗青
1. bg-light 白
1. bg-light-subtle 灰白
1. bg-dark 黑
1. bg-dark-subtle 深黑
1. bg-body-secondary 灰白
1. bg-body-tertiary 灰白+1
1. bg-body 深灰
1. bg-black 纯黑
1. bg-white 纯白
1. bg-transparent 透明

## 定位 [详见](https://v5.bootcss.com/docs/utilities/position/)

1. `position-static/relative/absolute/fixed/sticky` --设置定位
1. `fixed-top/bottom/start/end` --快速设置定位
1. `sticky-top/bottom/start/end` --滚动并经过某个元素之后,元素被固定在的顶部且边缘对齐
1. `top/start/bottom/end-0/50/100` --定位位置 start 为 left end 为 right
1. `translate-middle-||x/y||` -- 使盒子在定位时居中 x 为左右 y 为上下

1. `mt/mb/ms/me/mx/my/m -lg -1/5/n1 -margin/padding` 设置大小 方向 s 为 left e 为 right x 为左右 y 为上下 - 大小不带单位
1. `w/h/-25/50/75/100/auto` --设置相对于父级的宽/高占比 还有 `mw/vw/min-vw/` --m 为 max v 为 viewport
1. `d-||lg/md/sm|| - none/inline/inline-block/block/grid/table/table-cell/table-row/flex/inline-flex` --设置 display

## Flex [详见](https://v5.bootcss.com/docs/utilities/flex/)

1. `d-||lg/md/sm|| - flex/inline-flex` --使用 flex 盒子

1. `flex-||lg/md/sm|| - row/column-||reverse||` --排列方向 row 为左右 column 为垂直 reverse 为反向
1. `justify-content-||lg/md/sm|| - start/end/center/between/around/evenly` --设置子级左右排列方式,检测中测试再改 记得用 d-flex
1. `align- items/self - ||lg/md/sm|| - start/end/center/baseline/stretch` --设置 子级/自己 垂直方向对齐 记得用 d-flex
1. `align-content-||lg/md/sm|| - end/center/between/around/stretch` --设置内容对齐方式 检查中预览再用
1. `flex-||lg/md/sm|| - nowrap/wrap` --控制 flex 自动换行

1. `flex-||lg/md/sm|| - fill` -- 使同级宽度等于其内容 会超过父级盒子宽度 用于自动调整宽 可以给父级 `mw - 25/50/75/100` `overflow-hidden`

1. `flex-||lg/md/sm|| - grow-1/*` -- 跟上面一样自动设置宽度 让其余同级元素提供可用空间 也会超父级
1. `flex-||lg/md/sm|| - shrink-1/*` -- 这个可以让同级上一个 100%宽的元素 收缩空间 用处可以左边一个图片盒子 右边 2 行解释文本用这个

1. `ms/me/mb/mt-||lg/md/sm|| - auto` --这个可以自动调整边距 比如 3 个盒子 使用会向右推 2 距离 边缘盒子一起使用会对齐 margin - auto

1. `order-||lg/md/sm|| - 1/5 /first/last` --控制位置的顺序 第一个输入`order-5/last`会排在五个/最后一个位置

## Img [详见](https://v5.bootcss.com/docs/content/images/)

1. `img-fluid` --响应式图片 使图片随盒子大小变化而变化
1. `img-thumbnail` -- 有留白和圆角
1. `rounded` -- 设置圆角 详见上方 border
1. `float-start/end` --使图片有浮动

## Ratios||比例调整 [详见](https://v5.bootcss.com/docs/helpers/ratio/)

![图 19](https://s2.loli.net/2023/10/26/QIzJxCbmgAlEoFX.png)

1. `ratio` --父级使用,为了让子级调整比例 视频比例调整
1. `ratio- 1x1/4x3/16x9/21x9` 父级设置,设置对应比例必须跟上方一起使用

## 表格 [详见](https://v5.bootcss.com/docs/content/tables/)

![图 20](https://s2.loli.net/2023/10/26/i9hNpVUDqzYAvoB.png)

1. `table` -- table 默认样式
1. `table-border` --加入边框 bordered 是给 table 添加
1. `table-striped` -- 给子元素每一行增加斑马条纹样式 单数行深色
1. `table-condensed` -- 使表格变得更紧凑 v5 中 table-sm
1. `table-hover` -- 给表格中的每一行触发 hover 效果 ;table 添加效果

### 子级效果 [详见](https://v5.bootcss.com/docs/content/tables/#table-hover)

1. active -- 使元素保持 hover v5 中已移除
1. success -- 标识成功或积极的动作 绿色 v5 中 bg-success
1. info -- 标识普通的提示信息或动作 浅蓝 v5 中 bg-info
1. warning -- 标识警告或需要用户注意 浅黄 v5 中 bg-warning
1. danger -- 标识危险或潜在的带来负面影响的动作 浅红 v5 中 bg-danger ;子级效果

1. `table-responsive` -- 使子级表格在小屏幕上显示的时候添加水平滚动条

## LINK [详见](https://v5.bootcss.com/docs/helpers/stretched-link/)

![图 21](https://s2.loli.net/2023/10/26/QMb9NTvLFVjZAIX.png)

1. `stretched-link` --延伸链接 通过添加 after 添加触碰区域 父级要 relative 实用！
1. `link-opacity-10/25/50/75/100 ||-hover||` --设置链接不透明度
1. `link-underline-danger` --设置 a 标签下划线样式,可用上方文字信息更改下划线色彩
1. `link-offset-1/2/3` --修改下划线与文字间的距离!实用代码
1. `link-underline-opacity-0/10/25/50/75/100` --设置下划线透明度
1. `link-offset-2 link-offset-3-hover` --这样添加 hover 效果!
1. `link-primary/secondary/"body-emphasis"/……` --改变颜色 em 强调链接 ;color
1. `pe-none/auto` --防止元素交互 点击但是键盘无效 可选 删 href 和 disabled
1. `aria-disabled="true"` --随父级决定交互是否有效

## stacks||简易排版 [详见](https://v5.bootcss.com/docs/helpers/stacks/)

![图 22](https://s2.loli.net/2023/10/26/ySkHiRmCzda8snr.png)

![图 23](https://s2.loli.net/2023/10/26/LDGNegKh9BXEo82.png)

1. `vstack/hstack` --使用垂直/水平布局
1. `gap-1/5` --设置子级标签数量
   tips:用于简易 nav,使用 flex 智能排版,简易版栏栅排版

## badges||标签 [详见](https://v5.bootcss.com/docs/components/badge/)

![图 5](https://s2.loli.net/2023/10/25/PbGfHehlaLpdjcU.png)

1. `badge` --根据父级调整大小 可跟 `text-color` `bg-color` `text-bg-color` 来调整颜色
1. `badge-||lg/md/sm|| -rounded-pill` --设置圆角
1. `badge-||lg/md/sm||` --设置大小
1. `badge-||primary/secondary/success/danger/warning/info/light/dark/white||` --设置颜色

### 99+样式 [详见](https://v5.bootcss.com/docs/components/badge/#pill-badges)

![图 6](https://s2.loli.net/2023/10/25/TBSk9bEtYWxPDH3.png)

```html
<button type="button" class="btn btn-primary position-relative">
  Inbox
  <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
    99+
    <span class="visually-hidden">unread messages</span>
  </span>
</button>
```

### 未读提示 [详见](https://v5.bootcss.com/docs/components/badge/#unread-indicators)

![图 7](https://s2.loli.net/2023/10/25/Ij1AHzRg7nr8ocF.png)

```html
<button type="button" class="btn btn-primary position-relative">
  Profile
  <span class="position-absolute top-0 start-100 translate-middle p-2 bg-danger border border-light rounded-circle">
    <span class="visually-hidden">New alerts</span>
  </span>
</button>
```

## 进度条 只有 25 50 75 100 [详见](https://v5.bootcss.com/docs/components/progress/)

> 进度条只有 25 50 75 100 4 种进度,可以使用`aria-valuenow="25"`来设置进度条进度,`aria-valuemin="0"`来设置最小值,`aria-valuemax="100"`来设置最大值,`aria-label="Basic example"`来设置进度条的提示信息,`style="width: 25%"`来设置进度条的宽度,`role="progressbar"`来设置进度条的角色,`class="progress-bar"`来设置进度条的样式,`class="progress"`来设置进度条的样式,`class="progress-bar-striped"`来设置进度条的条纹样式,`class="progress-bar-animated"`来设置进度条的动画样式

### 默认样式 [详见](https://v5.bootcss.com/docs/components/progress/#basic-example)

![图 0](https://s2.loli.net/2023/10/25/zf5bDSFeskVR2OX.png)

```html
<div class="progress" role="progressbar" aria-label="Basic example" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
  <div class="progress-bar" style="width: 100%">100%</div>
</div>
```

> ;--`aria-label` 中属性--; `Default/Success/Info/Warning/Danger` --蓝 绿 天蓝 黄 红 背景色 `striped` --添加条纹

### 动画进度条 [详见](https://v5.bootcss.com/docs/components/progress/#animated-stripes) > `progress-bar` --添加条纹 `progress-bar-animated` --添加动画 && `progress-bar-striped` --添加条纹动画 添加到进度条 div 中

![图 4](https://s2.loli.net/2023/10/25/HSpeCAf7UucBMPY.png)

```HTML
<div class="progress" role="progressbar" aria-label="Animated striped example" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
  <div class="progress-bar progress-bar-striped progress-bar-animated" style="width: 75%"></div>
</div>
```

### 多个进度条 [详见](https://v5.bootcss.com/docs/components/progress/#multiple-bars)

![图 3](https://s2.loli.net/2023/10/25/kgHBcKwv2aZPRyE.png)

> `aria-valuenow="15"` --设置进度条进度 `aria-valuemin="0"` --设置最小值 `aria-valuemax="100"` --设置最大值 `aria-label="Segment one"` --设置进度条的提示信息 `style="width: 15%"` --设置进度条的宽度 `role="progressbar"` --设置进度条的角色 `class="progress-bar"` --设置进度条的样式 `class="progress"` --设置进度条的样式 `class="progress-bar-striped"` --设置进度条的条纹样式 `class="progress-bar-animated"` --设置进度条的动画样式

```html
<div class="progress-stacked">
  <div class="progress" role="progressbar" aria-label="Segment one" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" style="width: 15%">
    <div class="progress-bar"></div>
  </div>
  <div class="progress" role="progressbar" aria-label="Segment two" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width: 30%">
    <div class="progress-bar bg-success"></div>
  </div>
  <div class="progress" role="progressbar" aria-label="Segment three" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
    <div class="progress-bar bg-info"></div>
  </div>
</div>
```

### 多个进度条||特殊样式 [详见](https://v5.bootcss.com/docs/components/progress/#multiple-bars)

![图 2](https://s2.loli.net/2023/10/25/lkfQRHNc7Us3Axo.png)

```html
<div class="progress"  role="progressbar" aria-label="Example 1px high" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="height: 1px">
  <div class="progress-bar" style="width: 25%"></div>
</div>
<div class="progress" role="progressbar" aria-label="Example 20px high" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="height: 20px">
  <div class="progress-bar" style="width: 25%"></div>
</div>
```

## load 加载 [详见](https://v5.bootcss.com/docs/components/spinners/)
![图 0](https://s2.loli.net/2023/12/05/dOt2jqFvl1rZAPB.gif)

```html
<button class="btn btn-primary" type="button" disabled>
  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
  <span class="visually-hidden">Loading...</span>
</button>
<button class="btn btn-primary" type="button" disabled>
  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
  Loading...
</button>
```

## tooltip||提示框 [详见](https://v5.bootcss.com/docs/components/tooltips/)

![图 11](https://s2.loli.net/2023/10/26/voMQibIyB3wNKRx.png)

### JS:

> 先引入 bootstrap.js,再使用下发代码

```html
<script src="../bootstrap/bootstrap-5.3.0-alpha1-dist/js/bootstrap.bundle.js"></script>
```

```javascript
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
;
html:
```

### HTML:

```HTML
<button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Tooltip on top">
  Tooltip on top
</button>
```

## 弹出框与提示框 [popovers](https://v5.bootcss.com/docs/components/popovers/) [modal](https://v5.bootcss.com/docs/components/modal/)

![图 8](https://s2.loli.net/2023/10/25/TIhvrK8s3JRYq5F.png)

![图 9](https://s2.loli.net/2023/10/25/SncLtaECJxQ6rMD.png)

### 简易弹出框 [详见](https://v5.bootcss.com/docs/components/popovers/)

> 修改 `data-bs-title` 为内容 修改 `data-bs-content` 为标题 修改 `data-bs-custom-class` 为自定义类名 修改 `data-bs-placement` 为弹出位置 修改 `data-bs-toggle` 为触发方式 修改 `data-bs-trigger` 为触发方式 [详见](https://v5.bootcss.com/docs/components/popovers/)

#### HTML:

```HTML
    <button type="button" class="btn btn-primary" data-bs-toggle="popover" data-bs-placement="right"
        data-bs-custom-class="custom-popover" data-bs-title="Custom popover"
        data-bs-content="This popover is themed via CSS variables.">
        Custom popover
    </button>
```

#### JS;

```HTML
<script>
  const popoverTriggerList = document.querySelectorAll(
    '[data-bs-toggle="popover"]'
  );

  const popoverList = [...popoverTriggerList].map(
    (popoverTriggerEl) => new bootstrap.Popover(popoverTriggerEl)
  );
</script>
```

### 自定义弹出框容器 [详见](https://v5.bootcss.com/docs/components/popovers/)

![图 24](https://s2.loli.net/2023/10/26/2I8ZuvxJeFqiLwW.png)

> 修改 `data-bs-content-id` 为容器 id 修改 `data-bs-placement` 为弹出位置 修改 `data-bs-toggle` 为触发方式 修改 `data-bs-trigger` 为触发方式

##### HTML:

```HTML
  <button
    type="button"
    class="btn btn-lg btn-danger"
    data-bs-toggle="popover"
    data-bs-content-id="example"
    data-bs-placement="right"
  >
    Click to toggle popover
  </button>
```

> 自定义容器

```
<div class="d-none" id="example">114514</div>
```

##### JS:

```HTML
<script>
  const popoverTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="popover"]')
  );
  const popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
    let opts = {
      html: true,
    };
    if (popoverTriggerEl.hasAttribute("data-bs-content-id")) {
      opts.content = document.getElementById(
        popoverTriggerEl.getAttribute("data-bs-content-id")
      ).innerHTML;
    }
    return new bootstrap.Popover(popoverTriggerEl, opts);
  });
</script>
```

### modal 弹出框 类似 alert [详见](https://v5.bootcss.com/docs/components/modal/)

![图 9](https://s2.loli.net/2023/10/25/SncLtaECJxQ6rMD.png)

#### HTML:

> `data-bs-toggle="modal"` --触发方式 `data-bs-target="#exampleModal"` --目标容器 `data-bs-dismiss="modal"` --关闭方式 `data-bs-backdrop="static"` --点击背景不关闭 `data-bs-keyboard="false"` --按键不关闭 `data-bs-backdrop="false"` --点击背景不关闭

```
 <button
      type="button"
      class="btn btn-primary"
      data-bs-toggle="modal"
      data-bs-target="#exampleModal"
    >
      Launch demo modal
  </button>
```

> 自定义容器 修改 `data-bs-toggle` 为触发方式 修改 `data-bs-target` 为目标容器

```HTML
    <div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog"> <!-- 自定义是弹出框位置 有 modal-dialog-scrollable modal-dialog-centered --> modal-dialog-scrollable <!-- 是添加不是替换 -->
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">...</div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Close
            </button>
            <button type="button" class="btn btn-primary">Save changes</button>
          </div>
        </div>
      </div>
    </div>
```

#### JS: (可不写)

```HTML
<script>
  const myModal = document.getElementById("myModal");
  const myInput = document.getElementById("myInput");

  myModal.addEventListener("shown.bs.modal", () => {
    z;
    myInput.focus();
  });
</script>
```

## toast (消息)提示框 [详见](https://v5.bootcss.com/docs/components/toasts/)

![图 10](https://s2.loli.net/2023/10/25/nR2zw5UAEaQrlkN.png)

#### HTML:

> `data-bs-autohide="false"` --不自动关闭 `data-bs-delay="10000"` --10s 后关闭 `data-bs-animation="false"` --关闭动画 `data-bs-placement="top-end"` --弹出位置 `data-bs-toggle="toast"` --触发方式 `data-bs-target="#myToast"` --目标容器 写在弹窗容器上

```HTML
<button type="button" class="btn btn-primary" id="liveToastBtn">Show live toast</button>

<div class="toast-container position-fixed bottom-0 end-0 p-3">
  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <img src="..." class="rounded me-2" alt="...">
      <strong class="me-auto">Bootstrap</strong>
      <small>11 mins ago</small>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      Hello, world! This is a toast message.
    </div>
  </div>
</div>
```

#### JS:

```Javascript
const toastTrigger = document.getElementById('liveToastBtn')
const toastLiveExample = document.getElementById('liveToast')
if (toastTrigger) {
  toastTrigger.addEventListener('click', () => {
    const toast = new bootstrap.Toast(toastLiveExample)

    toast.show()
  })
}
```

### 多弹窗 [详见](https://v5.bootcss.com/docs/components/toasts/#multiple-toasts)

![图 12](https://s2.loli.net/2023/10/26/D8RNfatYxrk1Boj.png)

> `data-bs-autohide="false"` --不自动关闭 `data-bs-delay="10000"` --10s 后关闭 `data-bs-animation="false"` --关闭动画 `data-bs-placement="top-end"` --弹出位置 `data-bs-toggle="toast"` --触发方式 `data-bs-target="#myToast"` --目标容器 写在弹窗容器上

#### HTML:

```
  <div
    class="toast-container position-fixed bottom-0 end-0 p-3"
    id="toast-container"
  ></div>
```

> 弹窗模板

```HTML
<!-- 创建一个模板，用于生成弹窗 -->
    <template id="toast-template">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <img src="..." class="rounded me-2" alt="..." />
          <strong class="me-auto">Bootstrap</strong>
          <small>刚刚</small>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="toast"
            aria-label="Close"
          ></button>
        </div>
        <div class="toast-body">这是一个新的弹窗</div>
      </div>
    </template>
```

#### JS:

```HTML
<script>
  // 获取按钮元素
  var toastBtn = document.getElementById("toast-btn");
  // 获取容器元素
  var toastContainer = document.getElementById("toast-container");
  // 获取模板元素
  var toastTemplate = document.getElementById("toast-template");
  // 定义一个计数器，用于记录弹窗的数量
  var toastCount = 0;
  // 给按钮添加点击事件监听器
  toastBtn.addEventListener("click", function () {
    // 每次点击按钮，计数器加一
    toastCount++;
    // 克隆模板元素，生成一个新的弹窗元素
    var newToast = toastTemplate.content.cloneNode(true);
    // 给新的弹窗元素添加一个id属性，用于区分不同的弹窗
    newToast.querySelector(".toast").id = "toast-" + toastCount;
    // 把新的弹窗元素添加到容器元素中
    toastContainer.appendChild(newToast);
    // 获取新的弹窗元素
    var toastEl = document.getElementById("toast-" + toastCount);
    // 初始化新的弹窗元素
    var toast = new bootstrap.Toast(toastEl);
    // 显示新的弹窗元素
    toast.show();
  });
</script>

```

### 实时更改时间 [详见](https://v5.bootcss.com/docs/components/toasts/#live-demo) [本地](第三期/栏栅系统%20-%20系统运维中心/弹窗.html)

![图 25](https://s2.loli.net/2023/10/26/dugXRoeDIUbxC9M.png)

> `data-bs-autohide="false"` --不自动关闭 `data-bs-delay="10000"` --10s 后关闭 `data-bs-animation="false"` --关闭动画 `data-bs-placement="top-end"` --弹出位置 `data-bs-toggle="toast"` --触发方式 `data-bs-target="#myToast"` --目标容器 写在弹窗容器上

#### HTML:

```HTML
<!-- 创建一个按钮，用于触发弹窗 -->
    <button type="button" class="btn btn-primary" id="toast-btn">
      显示弹窗
    </button>

    <!-- 创建一个容器，用于存放弹窗 -->
    <div
      class="toast-container position-fixed bottom-0 end-0 p-3"
      id="toast-container"
    ></div>

    <!-- 创建一个模板，用于生成弹窗 -->
    <template id="toast-template">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <img src="..." class="rounded me-2" alt="..." />
          <strong class="me-auto">Bootstrap</strong>
          <small id="time">刚刚</small>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="toast"
            aria-label="Close"
            data-bs-autohide="false"
          ></button>
        </div>
        <div class="toast-body">这是一个新的弹窗</div>
      </div>
    </template>
```

#### js:

```html
<script>
  // 获取按钮元素
  var toastBtn = document.getElementById("toast-btn");
  // 获取容器元素
  var toastContainer = document.getElementById("toast-container");
  // 获取模板元素
  var toastTemplate = document.getElementById("toast-template");
  // 定义一个计数器，用于记录弹窗的数量
  var toastCount = 0;
  // 定义一个函数，用于格式化时间
  function formatTime(time) {
    // 获取当前时间和给定时间的差值（毫秒）
    var diff = Date.now() - time;
    // 如果差值小于1分钟，返回“刚刚”
    if (diff < 60 * 1000) {
      return "刚刚";
    }
    // 如果差值小于1小时，返回“x分钟前”
    if (diff < 60 * 60 * 1000) {
      return Math.floor(diff / (60 * 1000)) + "分钟前";
    }
    // 如果差值小于1天，返回“x小时前”
    if (diff < 24 * 60 * 60 * 1000) {
      return Math.floor(diff / (60 * 60 * 1000)) + "小时前";
    }
    // 否则，返回“x天前”
    return Math.floor(diff / (24 * 60 * 60 * 1000)) + "天前";
  }
  // 给按钮添加点击事件监听器
  toastBtn.addEventListener("click", function () {
    // 每次点击按钮，计数器加一
    toastCount++;
    // 克隆模板元素，生成一个新的弹窗元素
    var newToast = toastTemplate.content.cloneNode(true);
    // 给新的弹窗元素添加一个id属性，用于区分不同的弹窗
    newToast.querySelector(".toast").id = "toast-" + toastCount;
    // 给新的弹窗元素添加一个data-time属性，用于记录创建时间
    newToast.querySelector(".toast").dataset.time = Date.now();
    // 把新的弹窗元素添加到容器元素中
    toastContainer.appendChild(newToast);
    // 获取新的弹窗元素
    var toastEl = document.getElementById("toast-" + toastCount);
    // 初始化新的弹窗元素，并设置autohide选项为false
    var toast = new bootstrap.Toast(toastEl, { autohide: false });
    // 显示新的弹窗元素
    toast.show();
  });
  // 定义一个函数，用于更新所有弹窗的时间
  function updateTime() {
    // 获取所有的弹窗元素
    var toasts = document.querySelectorAll(".toast");
    // 遍历每个弹窗元素
    for (var i = 0; i < toasts.length; i++) {
      // 获取当前弹窗元素
      var toast = toasts[i];
      // 获取当前弹窗的创建时间
      var time = toast.dataset.time;
      // 获取当前弹窗的时间元素
      var timeEl = toast.querySelector("#time");
      // 更新时间元素的内容，用格式化后的时间替换原来的内容
      timeEl.textContent = formatTime(time);
    }
  }
  // 设置一个定时器，每隔1秒调用一次更新时间的函数
  setInterval(updateTime, 1000);
</script>
```
#### 限制数量
```html
<script>
  // 获取按钮元素
  var toastBtn = document.getElementById("toast-btn");
  // 获取容器元素
  var toastContainer = document.getElementById("toast-container");
  // 获取模板元素
  var toastTemplate = document.getElementById("toast-template");
  // 定义一个计数器，用于记录弹窗的数量
  var toastCount = 0;
  // 定义一个函数，用于格式化时间
  function formatTime(time) {
    // 获取当前时间和给定时间的差值（毫秒）
    var diff = Date.now() - time;
    // 如果差值小于1分钟，返回“刚刚”
    if (diff < 60 * 1000) {
      return "刚刚";
    }
    // 如果差值小于1小时，返回“x分钟前”
    if (diff < 60 * 60 * 1000) {
      return Math.floor(diff / (60 * 1000)) + "分钟前";
    }
    // 如果差值小于1天，返回“x小时前”
    if (diff < 24 * 60 * 60 * 1000) {
      return Math.floor(diff / (60 * 60 * 1000)) + "小时前";
    }
    // 否则，返回“x天前”
    return Math.floor(diff / (24 * 60 * 60 * 1000)) + "天前";
  }

  // 给按钮添加点击事件监听器
  toastBtn.addEventListener("click", function () {
    // 每次点击按钮，计数器加一
    toastCount++;
    // 如果弹窗数量超过2个，移除最早创建的一个
    if (toastContainer.childElementCount > 1) {
      var oldestToast = toastContainer.firstElementChild;
      toastContainer.removeChild(oldestToast);
    }
    // 克隆模板元素，生成一个新的弹窗元素
    var newToast = toastTemplate.content.cloneNode(true);
    // 给新的弹窗元素添加一个id属性，用于区分不同的弹窗
    newToast.querySelector(".toast").id = "toast-" + toastCount;
    // 给新的弹窗元素添加一个data-time属性，用于记录创建时间
    newToast.querySelector(".toast").dataset.time = Date.now();
    // 把新的弹窗元素添加到容器元素中
    toastContainer.appendChild(newToast);
    // 获取新的弹窗元素
    var toastEl = document.getElementById("toast-" + toastCount);
    // 初始化新的弹窗元素，并设置autohide选项为false
    var toast = new bootstrap.Toast(toastEl, { autohide: false }); //自动隐藏
    // 显示新的弹窗元素
    toast.show();
    //渐入
    $(".toast").fadeIn(1000);
  });

  // 定义一个函数，用于更新所有弹窗的时间
  function updateTime() {
    // 获取所有的弹窗元素
    var toasts = document.querySelectorAll(".toast");
    // 遍历每个弹窗元素
    for (var i = 0; i < toasts.length; i++) {
      // 获取当前弹窗元素
      var toast = toasts[i];
      // 获取当前弹窗的创建时间
      var time = toast.dataset.time;
      // 获取当前弹窗的时间元素
      var timeEl = toast.querySelector("#time");
      // 更新时间元素的内容，用格式化后的时间替换原来的内容
      timeEl.textContent = formatTime(time);
    }
  }

  // 设置一个定时器，每隔1秒调用一次更新时间的函数
  setInterval(updateTime, 1000);

  $(".div").focus(function (e) {
    event.preventDefault();
  });
</script>
```
### 图片轮播 [详见](https://v5.bootcss.com/docs/components/carousel/)

![图 13](https://s2.loli.net/2023/10/26/JQOeZUvHo4Bkj3a.png)

#### 轮播样式

> `data-bs-ride="carousel"` --启用轮播 `data-bs-interval="1000"` --轮播间隔 `data-bs-pause="hover"` --鼠标悬停暂停 `data-bs-wrap="false"` --循环轮播 `data-bs-keyboard="false"` --键盘控制轮播 `data-bs-slide="prev/next"` --控制轮播方向 `data-bs-slide-to="0/1/2"` --控制轮播跳转 写在父级上

##### HTML

```HTML
<!-- <div id="carouselExampleAutoplaying" class="carousel slide bg-success" data-bs-ride="true">禁用轮播 -->
<!-- <div id="carouselExampleAutoplaying" class="carousel slide bg-success" data-bs-ride="carousel">启用轮播 -->
    <div class="carousel-indicators"> <!--;显示下方跳转 data-bs-target 必须跟父级id相同-->
        <button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="0" class="active" aria-current="true"
            aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
  <div class="carousel-inner h-100">
    <div class="carousel-item active h-100">
        <img src="..." class="d-block w-100" alt="...">
        <div class="carousel-caption d-none d-md-block"> <!--;可选添加文字,注意父级高度-->
            <h5>First slide label</h5>
            <p>Some representative placeholder content for the first slide.</p>
        </div>
    </div>
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
```

#### 独立设置轮播时长 [详见](https://v5.bootcss.com/docs/components/carousel/#individual-carousel-item-interval)

![图 26](https://s2.loli.net/2023/10/26/BMe7bqYaVsWXQLf.png)

> `data-bs-interval="1000"` --轮播间隔 写在轮播子级上

##### HTML

```HTML
<!-- <div id="carouselExampleInterval" class="carousel slide bg-success carousel" data-bs-ride="carousel"> ;使用交叉淡化 -->
<!-- <div id="carouselExampleInterval" class="carousel slide bg-success" data-bs-ride="true"> ;点击一次后启动轮播 -->
    <div id="carouselExampleInterval" class="carousel slide bg-success" data-bs-ride="carousel">
        <div class="carousel-indicators"> <!--;显示下方跳转 data-bs-target 必须跟父级id相同-->
            <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="0" class="active"
                aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="1"
                aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="2"
                aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner h-100">
            <div class="carousel-item active h-100" data-bs-interval="1000"> <!--修改 data-bs-interval= 来设置切换时间-->
                <img src="..." class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block"> <!--;可选添加文字,注意父级高度-->
                    <h5>First slide label</h5>
                    <p>Some representative placeholder content for the first slide.</p>
                </div>
            </div>
            <div class="carousel-item" data-bs-interval="2000">
                <img src="..." class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="..." class="d-block w-100" alt="...">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval"
            data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval"
            data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
```

#### 交叉淡化 [详见](https://v5.bootcss.com/docs/components/carousel/#crossfade)

![图 14](https://s2.loli.net/2023/10/26/1Eb3kKPWwqNBgx6.png)

> `data-bs-ride="carousel"` --启用轮播 `data-bs-interval="1000"` --轮播间隔 `data-bs-pause="hover"` --鼠标悬停暂停 `data-bs-wrap="false"` --循环轮播 `data-bs-keyboard="false"` --键盘控制轮播 `data-bs-slide="prev/next"` --控制轮播方向 `data-bs-slide-to="0/1/2"` --控制轮播跳转 写在父级上

##### HTML

```HTML
<div id="carouselExampleFade" class="carousel slide carousel-fade">
    <div class="carousel-indicators"> <!--;显示下方跳转 data-bs-target 必须跟父级id相同-->
        <button type="button" data-bs-target="#carouselExampleFade" data-bs-slide-to="0" class="active"
            aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleFade" data-bs-slide-to="1"
            aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#carouselExampleFade" data-bs-slide-to="2"
            aria-label="Slide 3"></button>
    </div>
  <div class="carousel-inner h-100">
    <div class="carousel-item active h-100">
      <img src="..." class="d-block w-100" alt="...">
        <div class="carousel-caption d-none d-md-block"> <!--;可选添加文字,注意父级高度-->
            <h5>First slide label</h5>
            <p>Some representative placeholder content for the first slide.</p>
        </div>
    </div>
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
```

#### JS

```Javascript
const myCarouselElement = document.querySelector('#myCarousel');/*处填写最外层父级的id!*/

const carousel = new bootstrap.Carousel(myCarouselElement, {
  interval: 2000,
  touch: true, /*轮播是否应支持在触摸屏设备上进行左/右滑动交互。 有bug*/
  /*;---后面的都不知道怎么用---;*/
  keyboard: true, /*轮播是否对键盘做出反应*/
  pause:hover, /* 如果设置为 "hover" ，将暂停轮播的循环 如果设置为 false 将继续轮播 好像不能用 默认为hover*/
  wrap: true, /*轮播是应连续循环还是硬停止。*/
  ride:carousel, /*如果为 true ,则在用户手动循环第一项后自动播放轮播。如果设置为 carousel ，则在加载时自动播放轮播。*/
})
```

### 分页导航 [详见](https://v5.bootcss.com/docs/components/pagination/)

#### 样式一

![图 27](https://s2.loli.net/2023/10/30/8J9jTzy74tqkxHD.png)

##### HTML

```HTML
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">Next</a></li>
  </ul>
</nav>
```

#### 样式二

![图 28](https://s2.loli.net/2023/10/30/H5OpfSwGTBE89yz.png)

##### HTML

```HTML
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
```

#### 样式三

![图 29](https://s2.loli.net/2023/10/30/tAiSHy6dOBlnLkU.png)

##### HTML

> 修改 Ul 中的 `pagination-lg` 来调整大小 `pagination-sm`为小

```HTML
<nav aria-label="...">
  <ul class="pagination pagination-lg">
    <li class="page-item active" aria-current="page">
      <span class="page-link">1</span>
    </li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
  </ul>
</nav>
```

#### 样式四

![图 30](https://s2.loli.net/2023/10/30/ok63UOSQVfrXEum.png)

##### HTML

> 添加`disable` 来禁言某一选项

```HTML
<nav aria-label="...">
  <ul class="pagination">
    <li class="page-item disabled">
      <a class="page-link">Previous</a>
    </li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item active" aria-current="page">
      <a class="page-link" href="#">2</a>
    </li>
    <li class = "page-item"><a class = "page-link" href = "#">3</a></li>
    <li class = "page-item">
    <a  class = "page-link" href     = "#">Next</a>
    </li>
  </ul>
</nav>
```

---
