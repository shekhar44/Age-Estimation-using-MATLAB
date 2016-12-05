# Age-Estimation-using-MATLAB
# shitanshu shekhar/ B.tech / IT

This is mini project done by Shitanshu shekhar.
I have one GUI module in which i include all training , testing and picture show code.
 
In this project creteria used by us "age", According to age we sort the image. first of all adult came in front and then older one came.
The platform used in the project is 'MATLAB 2013'. 

In training we make training data set. For training purpose we use 100 image for 'adult' and 105 image for 'older' and then extract the Fearture of each figure 
and store it. we made a class file in which assign '0' for adult and '1' for older and include both the file in one file by "sv=svmtrain(f1,class)".

Then we extract the feature of "test data" and compare it to "training data" by "svmclassify(sv,f)", where 'sv' is feature of training data and 'f' is feature 
extract by testing data set. then show the picture by using "Subplot" in sorting order.

#Limitation of my project:-
I train the data set for adult and older only so, it show the child picture in adult series because support vector Machine (SVM)
support for two classes in MATLAB. 

# follow the step given in (followstep) file.
