DynamicMask
=====================

About
-----------

A demo project that implements dynamic mask on an image.

Principle
-----------

From the documentation of *[CGImageCreateWithMask](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CGImage/Reference/reference.html#//apple_ref/c/func/CGImageCreateWithMask)*, there are two ways of creating mask.

1. provide a static image that be in DeviceGray color space, and then the "filled" part of the image will be looked through after masked.
2. provide an alpha mask image and then the semi-transparent part of this image will be looked through after masked.

In my understanding and test, I find it easiser that programmatically create a mask in the second way.