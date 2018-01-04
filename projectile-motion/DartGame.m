%Siddharth Salunkhe
%Georgia Institute of Technology
%ME 2016 section E, Professor Mark Smith
%Last Updated: 8/27/2017
function varargout = DartGame(varargin)

% DARTGAME MATLAB code for DartGame.fig
%      DARTGAME, by itself, creates a new DARTGAME or raises the existing
%      singleton*.
%
%      H = DARTGAME returns the handle to a new DARTGAME or the handle to
%      the existing singleton*.
%
%      DARTGAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DARTGAME.M with the given input arguments.
%
%      DARTGAME('Property','Value',...) creates a new DARTGAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DartGame_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DartGame_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DartGame

% Last Modified by GUIDE v2.5 27-Aug-2017 11:51:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DartGame_OpeningFcn, ...
                   'gui_OutputFcn',  @DartGame_OutputFcn, ...
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


% --- Executes just before DartGame is made visible.
function DartGame_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DartGame (see VARARGIN)

% Choose default command line output for DartGame
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DartGame wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%--Initialize plots.-------------------------------------------------------
axes(handles.axes1);
axis([-2,12,-2,12]);
xlabel('Distance');
ylabel('Height');
box; grid;

% Set the initial text of the static text box "Result" and the edit text
% boxes to 0
set(handles.result,'String','Result');
set(handles.angle,'String',0);
set(handles.speed,'String',0);

% Read in the error image.
handles.message    = cell(1,1);
handles.message{1} = imread('error.png');

% Update the handles structure
guidata(hObject, handles);
%--------------------------------------------------------------------------



% --- Outputs from this function are returned to the command line.
function varargout = DartGame_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function angle_Callback(hObject, eventdata, handles)
% hObject    handle to angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angle as text
%        str2double(get(hObject,'String')) returns contents of angle as a double


% --- Executes during object creation, after setting all properties.
function angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function speed_Callback(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speed as text
%        str2double(get(hObject,'String')) returns contents of speed as a double


% --- Executes during object creation, after setting all properties.
function speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.result,'String','Result');
cla(handles.axes1);


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global display;
if (get(hObject,'Value') == get(hObject,'Max'))
	display = false;
else
    display = true;
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
global display
display = true;
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get contents of the edit boxes.
angle = str2double(get(handles.angle,'String'));
velocity = str2double(get(handles.speed,'String'));
set(handles.result,'String','Result');
% Make a plot.

axes(handles.axes1);
if isnan(angle) || isnan(velocity)
    % Display an error message.
    image(handles.message{1}); 
    pause(1);
    cla(handles.axes1);
    set(gca,'Ydir','Normal');
    box; grid;
else
    % Display a plot.
    
    set(handles.axes1, 'XLim', [-2,12], 'YLim', [-2,12]);
    xlabel('Distance');
    ylabel('Height');
    val = PlotTrajectories(angle,velocity,display);
    guidata(hObject, handles);
    
    % Evaluate the function at pi and return the result. 
    set(handles.result,'String',val);
end
%--------------------------------------------------------------------------
