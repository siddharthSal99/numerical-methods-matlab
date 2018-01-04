function varargout = guiDemo(varargin)
% GUIDEMO MATLAB code for guiDemo.fig
%      GUIDEMO, by itself, creates a new GUIDEMO or raises the existing
%      singleton*.
%
%      H = GUIDEMO returns the handle to a new GUIDEMO or the handle to
%      the existing singleton*.
%
%      GUIDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDEMO.M with the given input arguments.
%
%      GUIDEMO('Property','Value',...) creates a new GUIDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiDemo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiDemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiDemo

% Last Modified by GUIDE v2.5 17-May-2016 10:39:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiDemo_OpeningFcn, ...
                   'gui_OutputFcn',  @guiDemo_OutputFcn, ...
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


% --- Executes just before guiDemo is made visible.
function guiDemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiDemo (see VARARGIN)

% Choose default command line output for guiDemo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiDemo wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%--------------------------------------------------------------------------
% Set up the inital state of the gui as you want it to appear.
%
%--Initialize plots.-------------------------------------------------------
axes(handles.axes1);
x = linspace(0,2*pi,201);
y = sin(x);
plot(x,y);
axis([0 2*pi -1.2 1.2]);
xlabel('x');
ylabel('y');
box; grid;

% Evaluate the function at pi and return the result.
set(handles.resultPi,'String',0);

% Read in the error image.
handles.message    = cell(1,1);
handles.message{1} = imread('error.png');

% Update the handles structure
guidata(hObject, handles);
%--------------------------------------------------------------------------


% --- Outputs from this function are returned to the command line.
function varargout = guiDemo_OutputFcn(hObject, eventdata, handles) 
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

%--------------------------------------------------------------------------
% Code that executes when the button is pressed.
%
%--------------------------------------------------------------------------
% Get contents of the popup menu.
contents = cellstr(get(handles.popupmenu1,'String'));
fun = str2func(contents{get(handles.popupmenu1,'Value')});

% Get contents of the edit boxes.
amp = str2double(get(handles.editAmp,'String'));
phase = (pi/180)*str2double(get(handles.editPhase,'String'));

% Make a plot.
axes(handles.axes1);
if isnan(amp) || isnan(phase)
    % Display an error message.
    image(handles.message{1}); axis off;
else
    % Display a plot.
    x = linspace(0,2*pi,10);
    y = amp*fun(x+phase);
    plot(x,y);
    axis([0 2*pi -(1.2*amp) 1.2*amp]);
    xlabel('x');
    ylabel('y');
    box; grid;
    
    % Evaluate the function at pi and return the result.
    val = amp*fun(pi+phase);
    set(handles.resultPi,'String',val);
end
%--------------------------------------------------------------------------


function editAmp_Callback(hObject, eventdata, handles)
% hObject    handle to editAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAmp as text
%        str2double(get(hObject,'String')) returns contents of editAmp as a double


% --- Executes during object creation, after setting all properties.
function editAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPhase_Callback(hObject, eventdata, handles)
% hObject    handle to editPhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPhase as text
%        str2double(get(hObject,'String')) returns contents of editPhase as a double


% --- Executes during object creation, after setting all properties.
function editPhase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end