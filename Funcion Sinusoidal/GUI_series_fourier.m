function varargout = GUI_series_fourier(varargin)
% GUI_SERIES_FOURIER MATLAB code for GUI_series_fourier.fig
%      GUI_SERIES_FOURIER, by itself, creates a new GUI_SERIES_FOURIER or raises the existing
%      singleton*.
%
%      H = GUI_SERIES_FOURIER returns the handle to a new GUI_SERIES_FOURIER or the handle to
%      the existing singleton*.
%
%      GUI_SERIES_FOURIER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SERIES_FOURIER.M with the given input arguments.
%
%      GUI_SERIES_FOURIER('Property','Value',...) creates a new GUI_SERIES_FOURIER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_series_fourier_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_series_fourier_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_series_fourier

% Last Modified by GUIDE v2.5 19-Feb-2020 13:56:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_series_fourier_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_series_fourier_OutputFcn, ...
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


% --- Executes just before GUI_series_fourier is made visible.
function GUI_series_fourier_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_series_fourier (see VARARGIN)

% Choose default command line output for GUI_series_fourier
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_series_fourier wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_series_fourier_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function frec_Callback(hObject, eventdata, handles)
% hObject    handle to frec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frec as text
%        str2double(get(hObject,'String')) returns contents of frec as a double


% --- Executes during object creation, after setting all properties.
function frec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cant_per_Callback(hObject, eventdata, handles)
% hObject    handle to cant_per (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cant_per as text
%        str2double(get(hObject,'String')) returns contents of cant_per as a double


% --- Executes during object creation, after setting all properties.
function cant_per_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cant_per (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
clc
%------------ INPUT GENERAL -----------
A = str2double(get(handles.amp,'string'));
f = str2double(get(handles.frec,'string'));
cant_periodos = str2double(get(handles.cant_per,'string'));
comp_frecuencia = str2double(get(handles.comp_frec,'string'));
%---------- INPUT SINUSOIDAL ----------
opcion = get(handles.selector_theta,'Value');
%---------- PROCESS GENERAL ----------
t = linspace(0,cant_periodos/f,500);
switch opcion
    case 1
        theta = 0;
    case 2
        theta = pi/2;
    case 3
        theta = pi;
    case 4
        theta = 3*pi/2;
end
%-------- PROCESS SINUSOIDAL ---------
sinusoidal = A*sin(2*pi*f*t+theta);
%-------------------------------------------------------
%-------- PROCESS FOURIER CUADRADA ---------
f_cuadrada = 0;
for n=1:2:comp_frecuencia*2-1
    f_cuadrada = f_cuadrada+(1/n)*sin(2*pi*n*f*t);
end
%-------------------------------------------------------
%-------- PROCESS FOURIER TRIANGULAR ---------
triangular = 0;
omega = 2*pi*f;
for n=1:comp_frecuencia
    triangular = triangular+(cos((2*n-1)*omega*t))/((2*n-1)^2);
end
f_triangular = (A/2)-(4*A/pi^2)*triangular;
%-------------------------------------------------------
%-------- PROCESS DIENTE SIERRA ---------
diente = 0;
for n=1:comp_frecuencia
    diente = diente+((-1)^(n+1))*(1/n)*sin(2*pi*n*f*t);
end
f_diente_sierra = ((2*A)/pi)*diente;
%------------ OUTPUT GENERAL -----------
axes(handles.axes1)
plot(t,sinusoidal),grid on, title('Señal Sinusoidal')
axes(handles.axes2)
plot(t,f_cuadrada),grid on, title('Fourier Cuadrada')
axes(handles.axes3)
plot(t,f_triangular),grid on, title('Fourier Triangular')
axes(handles.axes4)
plot(t,f_diente_sierra),grid on, title('Fourier Diente Sierra')
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function comp_frec_Callback(hObject, eventdata, handles)
% hObject    handle to comp_frec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of comp_frec as text
%        str2double(get(hObject,'String')) returns contents of comp_frec as a double


% --- Executes during object creation, after setting all properties.
function comp_frec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to comp_frec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amp_Callback(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp as text
%        str2double(get(hObject,'String')) returns contents of amp as a double


% --- Executes during object creation, after setting all properties.
function amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in selector_theta.
function selector_theta_Callback(hObject, eventdata, handles)
% hObject    handle to selector_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selector_theta contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selector_theta


% --- Executes during object creation, after setting all properties.
function selector_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selector_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
