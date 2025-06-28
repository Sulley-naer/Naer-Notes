# Vue Swiper 轮播组件

> swiper 是一个支持触摸滑动的轻量级 JavaScript 滑动库，它可以实现各种滑动效果，如轮播图、图片切换、视频播放等。
>
> 它已经专门适配了 Vue，可以直接在 Vue 项目中使用。

## [Get Stand](https://swiper.js.cn/element)

1. 安装 Swiper

   ```bash
   npm install swiper --save
   ```

2. 导入 Swiper

   ```js
   import Swiper from "swiper";
   ```

3. 使用 Swiper

   ```html
   <template>
     <swiper-container
       :slides-per-view="3"
       :space-between="spaceBetween"
       :centered-slides="true"
       :pagination="{
          hideOnClick: true
        }"
       :breakpoints="{
          768: {
            slidesPerView: 3,
          },
        }"
       @swiperprogress="onProgress"
       @swiperslidechange="onSlideChange">
       <swiper-slide>Slide 1</swiper-slide>
       <swiper-slide>Slide 2</swiper-slide>
       <swiper-slide>Slide 3</swiper-slide>
     </swiper-container>
   </template>

   <script setup>
     import { register } from "swiper/element/bundle";

     register();

     const spaceBetween = 10;
     const onProgress = (e) => {
       const [swiper, progress] = e.detail;
       console.log(progress);
     };

     const onSlideChange = (e) => {
       console.log("slide changed");
     };
   </script>
   ```

   以上代码将创建一个包含 5 个 slide 的轮播图，并添加了分页、左右箭头的功能。

## 其他配置项

1. Swiper 特殊模块使用

   ```html
   <template>
     <div>
       <Swiper
         :slides-per-view="1"
         :loop="true"
         :pagination="{
                clickable: true,
                dynamicBullets: true
              }"
         :autoplay="true"
         :modules="modules"
         style="max-height: 265px">
         <SwiperSlide
           v-for="(slide, index) in slides"
           :key="index"
           :aria-label="index + 1 + ' / ' + slides.length">
           <img :src="slide.image" :alt="`Slide ${index + 1}`" />
         </SwiperSlide>

         <!-- If we need pagination -->
         <div class="swiper-pagination" slot="pagination"></div>
       </Swiper>
     </div>
   </template>

   <script setup>
     import Swiper, { SwiperSlide } from "swiper/vue"; //基本资源
     import { Autoplay, Pagination } from "swiper/modules"; //特殊模块需导入

     const modules = [Autoplay, Pagination]; //通过 :modules 使用所需模块
     //V-for 循环创建 slide 元素
     const slides = [
       { image: "https://via.placeholder.com/800x600" },
       { image: "https://via.placeholder.com/800x600" },
       { image: "https://via.placeholder.com/800x600" },
       { image: "https://via.placeholder.com/800x600" },
       { image: "https://via.placeholder.com/800x600" },
     ];
   </script>
   ```
