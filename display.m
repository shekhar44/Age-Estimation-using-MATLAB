display('WORK IN PROGRESS PLEASE WAIT .............');
  load('adult.mat','adult');
  load('older.mat','older');
  load('path.mat','path');
  k=1;
           for i= 1:size(adult,1)
           subplot(4,9,k);
           im1 = strcat(path,adult(i))
           im1 = cell2mat(im1);
           im1 = imread(im1);
           imshow(im1);
           k=k+1;
           end

           for i= 1:size(older,1)
           subplot(4,9,k);
           im1 = strcat(path,older(i))
           im1 = cell2mat(im1);
           im1 = imread(im1);
           imshow(im1);
           k=k+1;
           end
           display('WORK COMPLETED');

end
