function varargout = GUI_transmitters_analog(varargin)
% GUI_TRANSMITTERS_ANALOG MATLAB code for GUI_transmitters_analog.fig
%      GUI_TRANSMITTERS_ANALOG, by itself, creates a new GUI_TRANSMITTERS_ANALOG or raises the existing
%      singleton*.
%
%      H = GUI_TRANSMITTERS_ANALOG returns the handle to a new GUI_TRANSMITTERS_ANALOG or the handle to
%      the existing singleton*.
%
%      GUI_TRANSMITTERS_ANALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TRANSMITTERS_ANALOG.M with the given input arguments.
%
%      GUI_TRANSMITTERS_ANALOG('Property','Value',...) creates a new GUI_TRANSMITTERS_ANALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_transmitters_analog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_transmitters_analog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_transmitters_analog

% Last Modified by GUIDE v2.5 19-Feb-2020 14:54:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_transmitters_analog_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_transmitters_analog_OutputFcn, ...
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


% --- Executes just before GUI_transmitters_analog is made visible.
function GUI_transmitters_analog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_transmitters_analog (see VARARGIN)

% Choose default command line output for GUI_transmitters_analog
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_transmitters_analog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_transmitters_analog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
clc
%---------- INPUT ----------
opciont1 = get(handles.selector_theta1,'Value');
switch opciont1
    case 1
        thetax = 0;
    case 2
        thetax = pi/2;
    case 3
        thetax = pi;
    case 4
        thetax = 3*pi/2;
end
opciont2 = get(handles.selector_theta2,'Value');

switch opciont2
    case 1
        thetac = 0;
    case 2
        thetac = pi/2;
    case 3
        thetac = pi;
    case 4
        thetac = 3*pi/2;
end

% xt
Ax = str2double(get(handles.amp_datos,'string')); 
fx = str2double(get(handles.frec_datos,'string')); 
cpx = str2double(get(handles.cant_per_datos,'string'));

% Carrier
Ac = str2double(get(handles.amp_carrier,'string')); 
fc = str2double(get(handles.frec_carrier,'string')); 
cpc = str2double(get(handles.cant_per_carrier,'string'));

% Índice de modulación AM
m = 0.4; % m enntre 0 y 1

% Índice de modulación FM
nfm = 2; % nfm mayor o igual a 2

% Índice de modulación PM
npm = 2; % npm mayor o igual a 2

%-------- PROCESS ---------
% Carrier
tc = linspace(0,cpc/fc,500);
carrier = Ac*sin(2*pi*fc*tc+thetac);

% xt
tx = linspace(0,cpx/fx,500);
xt = Ax*sin(2*pi*fx*tx+thetax);

% Modulación AM
xam = (1+m*xt).*carrier; % Multiplicación punto a punto ".*"
% Modulación FM
xfm = Ac*sin(2*pi*fc*tc+nfm*xt);
% Modulación PM
xt_diff = Ax*sin(2*pi*fx*tx+(thetax+pi/2));
xpm = Ac*sin(2*pi*fc*tc+npm*xt_diff);

%--------- OUTPUT ----------
axes(handles.axes1)
plot(tx,xt),grid on, title('Datos Análogos x(t)')
axes(handles.axes2)
plot(tc,carrier),grid on, title('Señal portadora carrier')
axes(handles.axes3)
plot(tc,xam),grid on, title('Señal AM')
axes(handles.axes4)
plot(tc,xfm),grid on, title('Señal FM')
axes(handles.axes5)
plot(tc,xpm),grid on, title('Señal PM')
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function amp_datos_Callback(hObject, eventdata, handles)
% hObject    handle to amp_datos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp_datos as text
%        str2double(get(hObject,'String')) returns contents of amp_datos as a double


% --- Executes during object creation, after setting all properties.
function amp_datos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_datos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frec_datos_Callback(hObject, eventdata, handles)
% hObject    handle to frec_datos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frec_datos as text
%        str2double(get(hObject,'String')) returns contents of frec_datos as a double


% --- Executes during object creation, after setting all properties.
function frec_datos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frec_datos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cant_per_datos_Callback(hObject, eventdata, handles)
% hObject    handle to cant_per_datos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cant_per_datos as text
%        str2double(get(hObject,'String')) returns contents of cant_per_datos as a double


% --- Executes during object creation, after setting all properties.
function cant_per_datos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cant_per_datos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amp_carrier_Callback(hObject, eventdata, handles)
% hObject    handle to amp_carrier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp_carrier as text
%        str2double(get(hObject,'String')) returns contents of amp_carrier as a double


% --- Executes during object creation, after setting all properties.
function amp_carrier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_carrier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frec_carrier_Callback(hObject, eventdata, handles)
% hObject    handle to frec_carrier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frec_carrier as text
%        str2double(get(hObject,'String')) returns contents of frec_carrier as a double


% --- Executes during object creation, after setting all properties.
function frec_carrier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frec_carrier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cant_per_carrier_Callback(hObject, eventdata, handles)
% hObject    handle to cant_per_carrier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cant_per_carrier as text
%        str2double(get(hObject,'String')) returns contents of cant_per_carrier as a double


% --- Executes during object creation, after setting all properties.
function cant_per_carrier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cant_per_carrier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in selector_theta1.
function selector_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to selector_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selector_theta1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selector_theta1


% --- Executes during object creation, after setting all properties.
function selector_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selector_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in selector_theta2.
function selector_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to selector_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selector_theta2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selector_theta2


% --- Executes during object creation, after setting all properties.
function selector_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selector_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
