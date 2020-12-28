# LungDamage
Quantify tissue damage with ML
![ScreenShot](images/Workflow-01.png)


### Contact and Referencing

Any comments or questions can be directed to: Will Liberti at bliberti@bu.edu


If you use this in your work, please cite:

*Alveolar epithelial cell fate is maintained in a spatially restricted manner to promote lung regeneration after acute injury, _Liberti et al._ * 


### Basic Walkthrough


Take this example image:
![ScreenShot](images/image00.jpg)

```
>> % cd('images'); enter the images directory

>> RGB1 = DL_demo % load 'image00.jpg'
```



Isolate the moderately damaged tissue:
![ScreenShot](images/image02.png)

Isolate just the severely damaged tissue:
![ScreenShot](images/image03.png)


## Clustering multipe images

Sometimes you will want to cluster several images, or cluster relative to a known healthy, or known damaged  reference sample.


```
>> % cd('images/Unprocessed')
>> out = DL_demo_ref('S.jpg')
```
