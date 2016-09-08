# KGHorizontalStepper
A small horizontal progress bar implemetation

![alt tag](https://media.giphy.com/media/l0MYO9W6cHlBHOx9e/giphy.gif)
# how to use
```
KGHorizontalStepper *progress = [[KGHorizontalStepper alloc] init];
progress.stepCount = [NSNumber numberWithInteger:3];
progress.currentLevel = [NSNumber numberWithInteger:1];
progress.pointRadius = [NSNumber numberWithInteger:7];
progress.maxLineHeight = [NSNumber numberWithFloat: 5];
progress.achievedColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00];
// Add it to you view and animate it
[progress startanimation];
```
