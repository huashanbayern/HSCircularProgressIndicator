# HSCircularProgressIndicator
=======
##  作用
### 以圆圈动画的形式展示图片下载进度，当图片下载完成后，以外圆扩大同时内圆缩放的动画形式展示出该图片
=======
###  如何使用？
#### 1.  将HSCircularProgressIndicator.h和HSCircularProgressIndicator.m拖拽到你的项目中
#### 2.  使用+alloc，-initWithFrame:方法创建并初始化HSCircularProgressIndicator对象，然后将其添加至父控件上
#### 3.  在恰当的地方调用-[HSCircularProgressIndicator setProgress:]展示图片下载进度
#### 4.  在恰当的地方调用-[HSCircularProgressIndicator reveal]展示出下载完成后的图片
#### 5.  根据需要，-[HSCircularProgressIndicator reset]是可选的，不是必须的
=======
### 运行效果展示:
![](https://github.com/huashanbayern/HSCircularProgressIndicator/blob/master/运行效果展示.gif)

