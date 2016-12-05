        cam=videoinput('winvideo',1);
set(cam,'FramesPerTrigger',Inf)
set(cam,'ReturnedColorSpace','rgb');
cam.FrameGrabInterval=5;

start(cam);

while(cam.FramesAcquired<=100)
    
    data=getsnapshot(cam);
    diff_im = imsubtract(data(:,:,1),rgb2gray(data));
    diff_im=medfilt2(diff_im,[3 3]);
    diff_im=im2bw(diff_im,0.18);
    diff_im=bwareaopen(diff_im,300);
    bw=bwlabel(diff_im,8);
    
    stats=regionprops(bw,'BoundingBox','Centroid');
    imshow(data)
    hold on
    
    for object=1:length(stats)
        bb=stats(object).BoundingBox;
        bc=stats(object).Centroid;
        rectangle('Position',bb,'EdgecColor','r','LineWidth',2)
        plot(bc(1),bc(2),'-m+')
    end
    
    hold off
    
end

stop(cam);
flushdata(cam);
sprintf('%s','thank you');
