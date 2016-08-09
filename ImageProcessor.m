function varargout = ImageProcessor(varargin)
% IMAGEPROCESSOR M-file for ImageProcessor.fig
%      IMAGEPROCESSOR, by itself, creates a new IMAGEPROCESSOR or raises the existing
%      singleton*.
%
%      H = IMAGEPROCESSOR returns the handle to a new IMAGEPROCESSOR or the handle to
%      the existing singleton*.
%
%      IMAGEPROCESSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEPROCESSOR.M with the given input arguments.
%
%      IMAGEPROCESSOR('Property','Value',...) creates a new IMAGEPROCESSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageProcessor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageProcessor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageProcessor

% Last Modified by GUIDE v2.5 09-Aug-2016 06:40:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageProcessor_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageProcessor_OutputFcn, ...
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


% --- Executes just before ImageProcessor is made visible.
function ImageProcessor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageProcessor (see VARARGIN)

% Choose default command line output for ImageProcessor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageProcessor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageProcessor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadButton.
% ------loading an image to the Image processor
function loadButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image image2
[path, user_cance] = imgetfile();
if user_cance
    msgbox(sprintf('Error'),'Error','Error');
    return
end
image = imread(path);
image = im2double(image);
image2 = image;
axes(handles.originalImage);
imshow(image);

% --- Executes on button press in saveButton.
% ------ save the processed image
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global processed 
[file,path] = uiputfile('processed.jpg','Save Image');
imwrite(processed, [path file]);

% --- Executes on button press in resampleButton.
% ------ Re-sample original image at 25% scale using bi-linear interpolation
function resampleButton_Callback(hObject, eventdata, handles)
% hObject    handle to resampleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image processed
resampledImage = imresize(image, 0.25, 'bilinear');
processed = resampledImage;
axes(handles.processedImage);
imshow(resampledImage);

% --- Executes on button press in upsampleButton.
% ------up-sample down-sampled image back to original size using nearest-neighbor method
function upsampleButton_Callback(hObject, eventdata, handles)
% hObject    handle to upsampleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image processed
upsampledImage = imresize(image, 4, 'nearest');
processed = upsampledImage;
axes(handles.processedImage);
imshow(upsampledImage);


% --- Executes on button press in compareButton.
function compareButton_Callback(hObject, eventdata, handles)
% hObject    handle to compareButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function avgText_Callback(hObject, eventdata, handles)
% hObject    handle to avgText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of avgText as text
%        str2double(get(hObject,'String')) returns contents of avgText as a double


% --- Executes during object creation, after setting all properties.
function avgText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avgText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sdText_Callback(hObject, eventdata, handles)
% hObject    handle to sdText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sdText as text
%        str2double(get(hObject,'String')) returns contents of sdText as a double


% --- Executes during object creation, after setting all properties.
function sdText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sdText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in compressEntropyButton.
function compressEntropyButton_Callback(hObject, eventdata, handles)
% hObject    handle to compressEntropyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in compressRunlengthButton.
function compressRunlengthButton_Callback(hObject, eventdata, handles)
% hObject    handle to compressRunlengthButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in greyscaleButton.
% ------ Convert images to Gray scale with 8bpp format
function greyscaleButton_Callback(hObject, eventdata, handles)
% hObject    handle to greyscaleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image processed
greyImage = 0.2989 * image(:,:,1) + 0.5870 * image(:,:,2) + 0.1140 * image(:,:,3);
processed = greyImage;
axes(handles.processedImage);
imshow(greyImage);


