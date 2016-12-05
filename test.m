
display('WORK IN PROGRESS PLEASE WAIT .............');
load('sv.mat');                                                  % load the sv
face = vision.CascadeObjectDetector();                           % to detect the face in figure

var=cd;  
path=strcat(var,'\database\test\clooney\');
d=dir(path);
k=1;m=1;i=1;
       for j=3:length(d)
             image_name = d(j).name;
             image_path = strcat(path,image_name);
       im = imread(image_path);
         % figure;  imshow(im);
       im = rgb2gray(im);
      % bbox = step(FDetect,im);
        %imshow(im);hold on;
       
       points = detectSURFFeatures(im,'MetricThreshold',100);
        %points1 = detectMinEigenFeatures(im);
       points = points.selectStrongest(60);
       features = extractFeatures(im,points);
       f=features(:)';
       plot(points);
       a(i,:)=svmclassify(sv,f);                                 % compare the result of trainig data and testing data
       
       if(a(i)==0)
        adult{k,:}=d(j).name;
        k=k+1;
       end
       if(a(i)==1)
        older{m,:}=d(j).name;
        m = m +1;
       end
       
       i=i+1;
       
       end
       save('adult.mat','adult');
       save('older.mat','older');
       save('path.mat','path');
       display('WORK COMPLETED');
      
end
