function varargout = GuiOfsoftware(varargin)
% GUIOFSOFTWARE MATLAB code for GuiOfsoftware.fig
%      GUIOFSOFTWARE, by itself, creates a new GUIOFSOFTWARE or raises the existing
%      singleton*.
%
%      H = GUIOFSOFTWARE returns the handle to a new GUIOFSOFTWARE or the handle to
%      the existing singleton*.
%
%      GUIOFSOFTWARE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIOFSOFTWARE.M with the given input arguments.
%
%      GUIOFSOFTWARE('Property','Value',...) creates a new GUIOFSOFTWARE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GuiOfsoftware_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GuiOfsoftware_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GuiOfsoftware

% Last Modified by GUIDE v2.5 10-Apr-2018 17:37:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GuiOfsoftware_OpeningFcn, ...
                   'gui_OutputFcn',  @GuiOfsoftware_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before GuiOfsoftware is made visible.
function GuiOfsoftware_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GuiOfsoftware (see VARARGIN)
i=imread('gc.jpg');
axes(handles.logo);
imshow(i);

% Choose default command line output for GuiOfsoftware
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GuiOfsoftware wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GuiOfsoftware_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global noPlate;
global name;
global plate;
global phone;
global cnic;
global chasis;
global engine;
global fuel;
global seat;
global NR;
global im;
global g;
global se;
global gi;
global ge;
global gdiff;
global B;
global er;
global out1;
global F;
global H;
global final;
global Iprops;
global bb;


%% clear all axes(images)
cla(handles.im2)
cla(handles.im3)
cla(handles.im4)
cla(handles.im5)
cla(handles.im6)
cla(handles.im10)
cla(handles.im11)
cla(handles.im12)
cla(handles.im13)
cla(handles.im14)
cla(handles.im15)
cla(handles.im16)
%clear the text box
set(handles.edit1,'string','');
set(handles.edit2,'string','');
set(handles.edit5,'string','');
set(handles.edit6,'string','');
set(handles.edit7,'string','');
set(handles.edit8,'string','');
set(handles.edit9,'string','');
set(handles.edit10,'string','');
set(handles.edit11,'string','');
%clear variables
noPlate=[];
plate=[];
name=[];
phone=[];
cnic=[];
chasis=[];
engine=[];
fuel=[];
seat=[];
NR=[];
im=0;
g=0;
se=0;
gi=0;
ge=0;
gdiff=0;
B=0;
er=0;
out1=0;
F=0;
H=0;
final=0;
Iprops=0;
bb=0;

[fname,path]=uigetfile('*.*','enter the image');
fname=strcat(path,fname);
im=imread(fname);
axes(handles.im1);
imshow(im);

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global g;
global se;
global gi;
global ge;
global gdiff;
global B;
global er;
global out1;
global F;
global H;
global final;
global Iprops;
global bb;
global NR;

im=imresize(im,[400 NaN]); % Resizing the image keeping aspect ratio same.
g=rgb2gray(im); % Converting the RGB (color) image to gray (intensity).
g=medfilt2(g,[3 3]); % Median filtering to remove noise.
%% dilation
se=strel('disk',1); % Structural element (disk of radius 1) for morphological processing.
gi=imdilate(g,se); % Dilating the gray image with the structural element.
%% erosion
ge=imerode(g,se); % Eroding the gray image with structural element.
%% edge enhancement 
gdiff=imsubtract(gi,ge);% Morphological Gradient for edges enhancement.
axes(handles.im2);
imshow(gdiff)
%% clear edges
gdiff=mat2gray(gdiff); % Converting the class to double.
%% bright edges in image
gdiff=conv2(gdiff,[1 1;1 1]); % Convolution of the double image for brightening the edges.
axes(handles.im3);
imshow(gdiff)
%% increase the intensity of the edges(edges pr intensity barha de white color wali)
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1); % Intensity scaling between the range 0 to 1.
%% binary image
B=logical(gdiff); % Conversion of the class from double to binary. 
%% Eliminating the possible horizontal lines and filling holes
er=imerode(B,strel('line',50,0));% remove possible horizontal lines
out1=imsubtract(B,er);
F=imfill(out1,'holes');% Filling all the regions of the image.
%% Thinning the image to ensure character isolation.
H=bwmorph(F,'thin',1);
H=imerode(H,strel('line',3,90));
%% remove the stray pixels and clear the border
final=bwareaopen(H,100);% Selecting all the regions that are of pixel area more than 100.
final=imclearborder(final); % clear border 
axes(handles.im4);
imshow(final)
%% Two properties 'BoundingBox' and binary 'Image' corresponding to these
% Bounding boxes are acquired.
Iprops=regionprops(final,'BoundingBox','Image');
bb = round(reshape([Iprops.BoundingBox], 4, []).'); % reshape function convert the array into 4 by 17 but with the transport(.') it become 17 by 4 then round
axes(handles.im5);
imshow(final);
for idx = 1 : numel(Iprops) 
    rectangle('Position', bb(idx,:), 'edgecolor', 'red');
end
%% concantrate the bounding boxes 
NR=cat(1,Iprops.BoundingBox);% Selecting all the bounding boxes in matrix of order numberofboxesX4;


% Update handles structure
guidata(hObject, handles);
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global g;
global se;
global gi;
global ge;
global gdiff;
global B;
global er;
global out1;
global F;
global H;
global final;
global Iprops;
global bb;
global NR;
global r;
if get(handles.radiobutton3,'Value')
    % Calling of FindIndex function.
r=FindIndex(NR); % Function 'FindIndex' outputs the array of indices of boxes required for extraction of characters.

if ~isempty(r) % If succesfully indices of desired boxes are achieved.
    axes(handles.im6);
imshow(final);
    for j=1:numel(r)
    rectangle('Position', NR(r(j),:), 'edgecolor', 'green');
    end
else
    msgbox('Unable to extract the characters from the number plate.');
    
end
else
  r=FindIndex1(NR); % Function 'FindIndex' outputs the array of indices of boxes required for extraction of characters.
axes(handles.im6);
if ~isempty(r) % If succesfully indices of desired boxes are achieved.
    axes(handles.im6);
imshow(final);
    for j=1:numel(r)
    rectangle('Position', NR(r(j),:), 'edgecolor', 'green');
    end
    else
    msgbox('Unable to extract the characters from the number plate.');
     
    
 end
end

% Update handles structure
guidata(hObject, handles);
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global im;
global g;
global se;
global gi;
global ge;
global gdiff;
global B;
global er;
global out1;
global F;
global H;
global final;
global Iprops;
global bb;
global NR;
global r;
global I;
global number;
global alphabet;
global noPlate;
global letter;

if ~isempty(r) % If succesfully indices of desired boxes are achieved.
   
    I={Iprops.Image}; % Cell array of 'Image' (one of the properties of regionprops)
     noPlate=[]; % Initializing the variable of number plate string.
    number=[];
    alphabet=[];
     for v=1:length(r)
        N=I{1,r(v)}; % Extracting the binary image corresponding to the indices in 'r'.
      if v==1
        axes(handles.im10);
        imshow(N)
      end
      if v==2
        axes(handles.im11);
        imshow(N)
      end
      if v==3
        axes(handles.im12);
        imshow(N)
      end
      if v==4
        axes(handles.im13);
        imshow(N)
      end
      if v==5
        axes(handles.im14);
        imshow(N)
      end
      if v==6
        axes(handles.im15);
        imshow(N)
      end
      if v==7
        axes(handles.im16);
        imshow(N)
      end
     
        letter=readLetter(N); % Reading the letter corresponding the binary image 'N'.

        while letter=='O' || letter=='0' % Since it wouldn't be easy to distinguish
            if v<=3                      % between '0' and 'O' during the extraction of character
                letter='O';              % in binary image. Using the characteristic of plates in Karachi
            else                         % that starting three characters are alphabets, this code will
                letter='0';              % easily decide whether it is '0' or 'O'. The condition for 'if'
            end                          % just need to be changed if the code is to be implemented with some other
            break;                       % cities plates. The condition should be changed accordingly.
        end
        if letter=='0' || letter=='1' ||  letter=='2' ||  letter=='3' ||  letter=='4' ||  letter=='5' ||  letter=='6' ||  letter=='7' ||  letter=='8' ||  letter=='9' 
           number=[number letter];
        else
            alphabet=[alphabet letter];
        end
        %noPlate=[noPlate letter]; % Appending every subsequent character in noPlate variable.
     end
    noPlate=[alphabet number];
end


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global noPlate;
set(handles.edit1,'string',noPlate);


% Update handles structure
guidata(hObject, handles);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global noPlate;
global name;
global plate;
global phone;
global cnic;
global chasis;
global engine;
global fuel;
global seat;

 load MyDB
     for x=1:length(MyDB)
         recordplate=getfield(MyDB,{1,x},'PlateNumber');
         if strcmp(noPlate,recordplate)
             
             plate=MyDB(x).PlateNumber;
             name=MyDB(x).OwnerName;
             phone=MyDB(x).PhoneNo; 
              cnic=MyDB(x).CNIC_NO;
               chasis=MyDB(x).ChasisNumber; 
               engine=MyDB(x).EngineNo;
                fuel=MyDB(x).Type_of_Fuel;
                 seat=MyDB(x).SeatingCapacity;
         
         
         end
     end
     
    
     if ~isempty(plate)
         
     set(handles.edit2,'string',plate);
     set(handles.edit5,'string',name);
     set(handles.edit6,'string',phone);
     set(handles.edit7,'string',cnic);
     set(handles.edit8,'string',chasis);
     set(handles.edit9,'string',engine);
     set(handles.edit10,'string',fuel);
     set(handles.edit11,'string',seat);
     else 
         msgbox('Number is not registered');
     end
