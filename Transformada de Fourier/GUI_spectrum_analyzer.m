function varargout = GUI_spectrum_analyzer(varargin)
% GUI_SPECTRUM_ANALYZER MATLAB code for GUI_spectrum_analyzer.fig
%      GUI_SPECTRUM_ANALYZER, by itself, creates a new GUI_SPECTRUM_ANALYZER or raises the existing
%      singleton*.
%
%      H = GUI_SPECTRUM_ANALYZER returns the handle to a new GUI_SPECTRUM_ANALYZER or the handle to
%      the existing singleton*.
%
%      GUI_SPECTRUM_ANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SPECTRUM_ANALYZER.M with the given input arguments.
%
%      GUI_SPECTRUM_ANALYZER('Property','Value',...) creates a new GUI_SPECTRUM_ANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_spectrum_analyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_spectrum_analyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_spectrum_analyzer

% Last Modified by GUIDE v2.5 19-Feb-2020 13:18:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_spectrum_analyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_spectrum_analyzer_OutputFcn, ...
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


% --- Executes just before GUI_spectrum_analyzer is made visible.
function GUI_spectrum_analyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_spectrum_analyzer (see VARARGIN)

% Choose default command line output for GUI_spectrum_analyzer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_spectrum_analyzer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_spectrum_analyzer_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in graficar.
function graficar_Callback(hObject, eventdata, handles)
clc
%---------- INPUT ----------
f = str2double(get(handles.frec,'string'));
cant_periodos = str2double(get(handles.cant_per,'string'));
comp_frecuencia = str2double(get(handles.comp_frec,'string'));
%-------- PROCESS ----------
t = linspace(0,cant_periodos/f,500);
f_transformada = 0;
f_cuadrada = 0;

for n=1:2:comp_frecuencia*2-1
    f_transformada = f_transformada+abs(fftshift(fft((1/n)*sin(2*pi*n*f*t))));
    f_cuadrada = f_cuadrada+(1/n)*sin(2*pi*n*f*t);
end
% 'abs' es valor absoluto
% 'fft' aplica la transformada rápida de fourier

%--------- OUTPUT ----------
axes(handles.axes1)
plot(t,f_cuadrada),grid on, title('Señal en el Dominio del Tiempo')
axes(handles.axes2)
plot(f_transformada),grid on, title('Espectro Completo (-\infty;\infty)')
axes(handles.axes3)
plot(f_transformada(250:300)),grid on, title('Espectro Positivo')
% hObject    handle to graficar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in salir.
function salir_Callback(hObject, eventdata, handles)
close
% hObject    handle to salir (see GCBO)
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
