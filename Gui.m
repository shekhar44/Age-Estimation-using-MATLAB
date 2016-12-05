function varargout = Gui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
end


function Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui (see VARARGIN)

% Choose default command line output for Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end


function varargout = Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
varargout{1} = handles.output;
end


% --- Executes on button press in training.
function training_Callback(hObject, eventdata, handles)
% hObject    handle to training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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

% --- Executes on button press in load_test.
function load_test_Callback(hObject, eventdata, handles)
% hObject    handle to load_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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




% --- Executes on button press in result.
function result_Callback(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
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

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
exit;                                                                   % to exit all the process
end
