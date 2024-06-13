# Jquery [详见](https://www.runoob.com/jquery/jquery-tutorial.html)

## 事件合集 [详见](https://www.runoob.com/jquery/jquery-ref-events.html)

1. `$('#/. ').click(function(){})` --添加对应事件 `onmouseover` `onmouseout`
1. `$('#/. ').hide()` --隐藏元素事件,不能用 `this`
1. `$('#/. ').change(function(){})` --添加监听事件 .attr('') 监听属性值变化
1. `$('#/. ').each(function(i,name){})` --遍历元素 根据元素的长度 使元素所有都执行代码 name 为元素名称 i 为元素序号 函数内使用名称相当于 `this`
1. `$('#/. ').on('click focus',function(){})` --给元素绑定多个事件
1. `$('#/. ').on('click', '$('#/.son ')',function(){})` --给元素下子级元素绑定事件 用处：只有一个绑定事件 必须为子级！
1. `$('#/. ').on({click:function(){},focus:function(){}})` -- 快速给元素绑定多事件，拟似 css 语法 逗号隔开
1. `$('#/. ').off('click')` --关闭元素绑定事件
1. `$('#/. ').one('click',function(){})` --给元素绑定一次性事件
1. `$('#/. ').focus(function(){event.p })` --让元素直接触发 `focus` 事件 可以不添加事件 触发已有
1. `$('#/. ').trigger('focus',function(){})` --让元素直接触发 `focus` 事件 可以不添加事件 触发已有
1. `$('.input2').triggerHandler('focus')` --让元素触发 `focus` 但网页 `focus` 不会获得焦点

> ## 函数内事件

1. `event` 阻止元素冒泡

> event 可以简写为 e

```Javascript
  $('#/. ').click(function(e){
    e.preventDefault()
    return false //阻止元素默认行为

  e.stopPropagation() //阻止元素冒泡
})
```

## 基本操作 [详见](https://www.runoob.com/jquery/jquery-ref-selectors.html)

1. `$('#/. ').css('color','blue').css('font-size','30px'),{}` --添加行内 css
1. `$('#/. ').css({})` --添加行内 css 这样是跟 css 文件一样写法 属性值记得用引号 逗号隔开属性
1. `$('#/. ').addClass('cl1 cl2')` --添加类名
1. `$('#/. ').removeClass('cl1')` --删除类名
1. `$('#/. ').toggleClass('cl1')` --有就删除没有就添加
1. `$('#/. ').toggleClass('active').siblings().removeClass('active')` --排它 让同级的其他元素先还原再添加 act

1. `$('[type=checkbox]')`. --获取复选框盒子
1. `$('#/. :not(:last)')`. --获取元素排除最后一个


1. `console.log($('#/.').css('color'))` --返回对应属性的值
1. `$('#/.').width()` -- 返回宽属性的值 ()内不写参数为获取,写参数为设置 `Height` 同理
1. `$('#/.').height()` -- 返回高属性的值 ()内不写参数为获取,写参数为设置 `Width` 同理
1. `$('#/.').innerWidth()` -- 返回宽属性 + `padding` 合的值 ()内必须为空 `innerHeight` 同理
1. `$('#/.').innerHeight()` -- 返回高属性 + `padding` 合的值 ()内必须为空 `innerwidth` 同理
1. `$('#/.').outerWidth()` -- 返回宽属性 + `padding` + `border` 合的值 ()为 `true` 时计算 `margin` `innerHeight` 同理
1. `$('#/.').outerHeight()` -- 返回宽属性 + `padding` + `border` 合的值 ()为 `true` 时计算 `margin` `innerHeight` 同理
1. `$('#/.').offset()` -- 返回元素相对于文档的位置 可用`.top` `.left` 返回对应的值 只会返回 `top` 和 `left` 的值
1. `$('#/.').scroll()` -- 返回当前进度条位置

### 滚动条事件

> `scrollTop()` --获取垂直滚动条位置 `scrollLeft()` --获取水平滚动条位置 `$(window).scroll(function(){})` --滚动条滚动事件 `console.log(window.pageYOffset)` --获取滚动条位置 新版本 `console.log(document.documentElement.scrollTop)` --获取滚动条位置 老版本

```Javascript
 $(window).scroll(function(){
  if($(document).scrollTop()>=1200){}
      $('#/.').click(function(){
        $("html").animate({scrollTop:0},500/*时间*/);
  })
})
```

#### 滚动条绑定导航栏跳转 [详见](第三期/淘宝网/index.html)

![图 31](https://s2.loli.net/2023/11/08/UpXLOPfbAKstNli.gif)  


##### JS

> `$(".fixedtool>ul>li")`为导航栏 `$(".floor>div")`为楼层 根据`索引号`跳转对应位置

```HTML
<script>
  //点击事件
  $(".fixedtool>ul>li").click(function () {
    let i = $(this).index();
    // 停止之前的动画效果
    $("html,body").stop();
    // 同时选择HTML和BODY元素
    $("html,body").animate({ scrollTop: $(".floor>div").eq(i).offset().top });
  });

  $(".fixedtool").hide();

  $(window).scroll(function () {
    let jdt = $(document).scrollTop();

    $("HTMl").css("user-select", "none");

    $(".floor>div").each(function (i, ele) {
      if (jdt >= $(ele).offset().top) {
        $(".fixedtool>ul>li")
          .eq(i)
          .addClass("active")
          .siblings()
          .removeClass("active");
      }
    });

    //动画效果
    if (jdt > 100) {
      $(".fixedtool").stop().animate({ top: 150, opacity: 1 }, 500).show();
    } else {
      $(".fixedtool").stop().animate({ top: -150, opacity: 0.1 }, 500);
    }
  });
</script>

```

1. `$('div:first / last / eq(0) / odd / even')`--获取 第一/最后/索引号为 0/奇数/偶数 的元素

1. `$('#/. ').html('')` --类似 innerHTML
1. `$('#/. ').text('')` --类似 innerText
1. `$('#/. ').val('')` --获取元素 value
1. `$('#/. ').parent('')` --查找父级 单层 就近原则
1. `$('#/. ').children('')` --查找子级 单层
1. `$('#/. ').find('')` --查找子级 多层

1. `$('#/. ').siblings('')` --查找同级 不包括自己
1. `$('#/. ').prevAll('')` --查找当前元素之前所有同级
1. `$('#/. ').nextAll('')` --查找当前元素之后所有同级

1. `$('#/. ').prop('属性名称')` --获取元素自带属性内容 href
1. `$('#/. ').prop('属性名称','属性值')` --修改元素自带属性内容 href

1. `$('#/. ').attr('属性名称')` --获取自定义属性内容
1. `$('#/. ').attr('属性名称','属性值')` --修改自定义属性内容

1. `$('#/. ').hasClass('class')` --检查当前元素是否含有某个特定的类,返回 true false,.

1. `$('#/. ').substr(2,3)` -- 截取字符串 从第二个开始截取三个 -1 为最后一个

1. `$('#/. ').index()` --获取当前元素的索引号

1. `$('#/. ').attr('src').indexOf("-on.png")` -- 获取元素 src 路径中带有 on 的元素

1. `$('#/. ').attr('src').replace("-on.png", "-off.png");` --将 src 中的 on 变为 off

## 动画 [详见](https://www.runoob.com/jquery/jquery-ref-effects.html)

1. `$('#/. ').show(1000,function(){})` --js 添加显示动画时间 ;---自定义动画---;
1. `$('#/. ').hide(1000,function(){})` --js 添加隐藏动画时间 ;---自定义动画---;

1. `animate(params,[speed],[easing],[fn])` ---定义 css 动画,[]可不写 params 为动画 speed 为时间 easing 效果 智能|平滑("swing","linear") fn 回调函数(结算时执行)
1. `fadeIn()` --- 透明下滑显示
1. `fadeOut()` --- 上滑逐渐透明
1. `fadeTO(time,30)` --- 设置 30 透明度
1. `stop()` ---停止所有动画

### 下拉显示框渐显 [详见](第三期/点击切换导航图片/index.html)

![GIF 2023-11-6 19-52-00.gif](https://s2.loli.net/2023/11/06/SV7uF8HZx9WTl3v.gif)

#### HTML

```HTML
<main class="mt-5 m-auto text-center ul-head">
    <ul class="list-group">
    <li class="list-group-item active" aria-current="true">An active item</li>
    <li class="list-group-item">A second item</li>
    <li class="list-group-item">A third item</li>
    <li class="list-group-item">A fourth item</li>
    <li class="list-group-item">And a fifth one</li>
    </ul>
</main>
```

#### JS

> `$('.ul-head').hover(function(){})` --鼠标悬停事件 `$(this)` --当前元素 `$(this).children('ul')` --当前元素的子元素 `$(this).children('ul').children('li')` --当前元素的子元素的子元素 `slideToggle(200)` --200ms 内显示隐藏 `stop()` --停止动画

```
$('.ul-head').hover(function () {
    $(this).children('ul').children('li').stop().slideToggle(200)
    })
```

### 排他元素 [详见](第三期/点击切换导航图片/index.html)

![GIF 2023-11-6 19-56-11.gif](https://s2.loli.net/2023/11/06/BWZzctHo731rDsh.gif)

#### JS

> `$(this).toggleClass('active').siblings().removeClass('active')` --当前元素添加类名,同级元素移除类名

> `$('.at').eq($(this).index('.ad')).addClass('act').siblings().removeClass('act')` 使其他盒子中的元素也跟随变化,`index` 为当前元素的索引号,`eq` 为**索引号**对应的元素 在数量不同时 `index("")` 务必添加**判定条件**

```Javascript
$('.ad').click(function () { /*ad为文字盒子*/
    $(this).toggleClass('active').siblings().removeClass('active')
    $('.at').eq($(this).index('.ad')).addClass('act').siblings().removeClass('act') /*at为显示盒子*/
})
```

### 对象的创建和合并

> `$.extend(obj1,obj2)` 中的第一个对象为被合并的对象,后面的对象为合并的对象 如前面添加`true` 会创建一个全新的对象 不是第一个 修改不影响被合并的对象
```HTML
<script>
var newobj = {}; // 先定义newobj
$(function(){
    var obj = {
        user:{
            name:'zs',
            old:'20'
        }
    };
    var obj2 = {
        work:{
            工作:'自由',
            工龄:'10'
        }
    };
    var obj3 = {
        薪水:{
            月薪:'5000',
            年薪:'10000'
        }
    };
    $.extend(true, newobj, obj, obj2, obj3); // 把多个对象合并到newobj
    console.log(newobj); // 打印newobj
})

</script>
```
