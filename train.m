display('WORK IN PROGRESS PLEASE WAIT .............'); 
var=cd;                                                         % it store the current working path
path=strcat(var,'\database\train\');
d=dir(path);                                                    % list all directry in the folder
k=1;c=0;
   for i=3:length(d)                                            % this loop used to reach to the training folder
       dir_name = d(i).name;
       path_name = strcat(path,dir_name,'\');
       d1 = dir(path_name);
       
       for j=3:length(d1)                                       % this loop used to get the image name
             image_name = d1(j).name;
             image_path = strcat(path_name,image_name);
       im = imread(image_path);                                 % to read the image
          %figure;  imshow(im);
       im = rgb2gray(im);                                       %convert the rbg pic to grayscale(black & white) for better result
        imshow(im);hold on;                                     % to show the image
       points = detectSURFFeatures(im,'MetricThreshold',100);   % to detect the feature of figure
        %points1 = detectMinEigenFeatures(im);
      points = points.selectStrongest(60);
       features = extracttFeatures(im,points); 
       f=features(:);                                           % collect all fearure in a single column
       f1(k,:)=f';                                              % transpose of matrix
       class(k,:) = c;
       k=k+1;
       plot(points);                                            % plot the point on figure
       end
           c=c+1; 
           
    end   
sv=svmtrain(f1,class);                                          % include the feature and class file
save('sv.mat','sv');                                            % to save the sv
display('WORK COMPLETED');                                      % display comment 
end
