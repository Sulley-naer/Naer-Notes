# SWIPER [详见](https://swiperjs.com/get-started)

![图 15](https://s2.loli.net/2023/10/26/M5O9HzNlLaoi6me.png)

> 成品页 [详见](https://swiperjs.com/demos/)

## HTML

```html
<div class="swiper">
        <div class="swiper-wrapper">
            <div class="swiper-slide">Slide 1</div>
            <div class="swiper-slide">Slide 2</div>
            <div class="swiper-slide">Slide 3</div>
            <div class="swiper-slide">Slide 4</div>
            <div class="swiper-slide">Slide 5</div>
            <div class="swiper-slide">Slide 6</div>
        </div>
        <!-- 如果需要分页器 -->
        <div class="swiper-pagination"></div>

        <!-- 如果需要导航按钮 -->
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>

        <!-- 如果需要滚动条 -->
        <div class="swiper-scrollbar"></div>
    </div>
```

## JS

```HTML
<script src="../swiper/swiper-bundle.min.js"></script>
    <script>
        var mySwiper = new Swiper('.swiper', { /* ... */ });
        var mySwiper = new Swiper('.swiper', {
            direction: 'horizontal', // 垂直切换选项 vertical/horizontal 竖/横
            loop: true, // 循环模式选项

            // 如果需要分页器
            pagination: {
                el: '.swiper-pagination',
            },

            // 如果需要前进后退按钮
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },

            // 如果需要滚动条
            scrollbar: {
                el: '.swiper-scrollbar',
            },
        })
    </script>
```

---
