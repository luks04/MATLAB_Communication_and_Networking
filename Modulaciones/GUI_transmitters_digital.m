function varargout = GUI_transmitters_digital(varargin)
% GUI_TRANSMITTERS_DIGITAL MATLAB code for GUI_transmitters_digital.fig
%      GUI_TRANSMITTERS_DIGITAL, by itself, creates a new GUI_TRANSMITTERS_DIGITAL or raises the existing
%      singleton*.
%
%      H = GUI_TRANSMITTERS_DIGITAL returns the handle to a new GUI_TRANSMITTERS_DIGITAL or the handle to
%      the existing singleton*.
%
%      GUI_TRANSMITTERS_DIGITAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TRANSMITTERS_DIGITAL.M with the given input arguments.
%
%      GUI_TRANSMITTERS_DIGITAL('Property','Value',...) creates a new GUI_TRANSMITTERS_DIGITAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_transmitters_digital_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_transmitters_digital_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_transmitters_digital

% Last Modified by GUIDE v2.5 19-Feb-2020 15:44:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_transmitters_digital_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_transmitters_digital_OutputFcn, ...
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


% --- Executes just before GUI_transmitters_digital is made visible.
function GUI_transmitters_digital_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_transmitters_digital (see VARARGIN)

% Choose default command line output for GUI_transmitters_digital
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_transmitters_digital wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_transmitters_digital_OutputFcn(hObject, eventdata, handles) 
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
optheta = get(handles.selector_theta,'Value');
switch optheta
    case 1
        thetac = 0;
    case 2
        thetac = pi/2;
    case 3
        thetac = pi;
    case 4
        thetac = 3*pi/2;
end

% Regla del bit
opreglabit = get(handles.selector_regla_bit,'Value');
switch opreglabit
    case 1
        regla_bit_alto = 0;
    case 2
        regla_bit_alto = 1;
end

datos = get(handles.xdatos,'string');

% Regla de modulación ask
opreglaASK = get(handles.regla_ask,'Value');
switch opreglaASK
    case 1
        regla_ask_transmite_carrier = 1;
    case 2
        regla_ask_transmite_carrier = 0;
end

% Regla de modulación fsk
opreglaFSK = get(handles.regla_fsk,'Value');
switch opreglaFSK
    case 1
        regla_fsk_transmite_carrier = 1;
    case 2
        regla_fsk_transmite_carrier = 0;
end

% Regla de modulación psk
opreglaPSK = get(handles.regla_psk,'Value');
switch opreglaPSK
    case 1
        regla_psk_transmite_carrier = 1;
    case 2
        regla_psk_transmite_carrier = 0;
end

% Carrier
Ac = str2double(get(handles.amp_c,'string')); 
fc = str2double(get(handles.frec_c,'string'));

%-------- PROCESS ---------
tb = 100; 
uno = ones(1,tb);
cero = zeros(1,tb);
frame = [];
frameInv = [];

for n=1:length(datos)
    if(datos(n)=='1')
        frame = [frame uno];
        frameInv = [frameInv cero];
    else
        frame = [frame cero];
        frameInv = [frameInv uno];
    end
end

if(regla_bit_alto==1)
    cadenaBits = 5*frame;
else
    cadenaBits = 5*frameInv;
end

% Carrier
tc = linspace(0,2*length(datos)/fc,length(cadenaBits));
carrier = Ac*sin(2*pi*fc*tc+thetac);

% Modulación ASK
if(regla_ask_transmite_carrier == 1)
    ask = frame.*carrier;
else
    ask = frameInv.*carrier;
end

% Modulación FSK
if(regla_fsk_transmite_carrier == 1)
    fsk = frame.*carrier+frameInv.*(Ac*sin(2*pi*(fc/2)*tc+thetac));
else
    fsk = frameInv.*carrier+frame.*(Ac*sin(2*pi*(fc/2)*tc+thetac));
end

% Modulación PSK
if(regla_psk_transmite_carrier == 1)
    psk = frame.*carrier+frameInv.*(Ac*-sin(2*pi*(fc)*tc+thetac));
else
    psk = frameInv.*carrier+frame.*(Ac*-sin(2*pi*(fc)*tc+thetac));
end

%--------- OUTPUT ----------
titulo = cat(2, 'DATOS: ', datos);
axes(handles.axes1)
plot(cadenaBits),grid on, title(titulo)
axis([0 length(cadenaBits) -1 6])

axes(handles.axes2)
plot(carrier),grid on, title('Carrier')
axis([0 length(carrier) -Ac Ac])

axes(handles.axes3)
plot(ask),grid on, title('ASK')
axis([0 length(cadenaBits) -Ac Ac])

axes(handles.axes4)
plot(fsk),grid on, title('FSK')
axis([0 length(cadenaBits) -Ac Ac])

axes(handles.axes5)
plot(psk),grid on, title('PSK')
axis([0 length(cadenaBits) -Ac Ac])
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function xdatos_Callback(hObject, eventdata, handles)
% hObject    handle to xdatos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xdatos as text
%        str2double(get(hObject,'String')) returns contents of xdatos as a double


% --- Executes during object creation, after setting all properties.
function xdatos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xdatos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amp_c_Callback(hObject, eventdata, handles)
% hObject    handle to amp_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp_c as text
%        str2double(get(hObject,'String')) returns contents of amp_c as a double


% --- Executes during object creation, after setting all properties.
function amp_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frec_c_Callback(hObject, eventdata, handles)
% hObject    handle to frec_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frec_c as text
%        str2double(get(hObject,'String')) returns contents of frec_c as a double


% --- Executes during object creation, after setting all properties.
function frec_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frec_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cant_per_c_Callback(hObject, eventdata, handles)
% hObject    handle to cant_per_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cant_per_c as text
%        str2double(get(hObject,'String')) returns contents of cant_per_c as a double


% --- Executes during object creation, after setting all properties.
function cant_per_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cant_per_c (see GCBO)
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


% --- Executes on selection change in selector_regla_bit.
function selector_regla_bit_Callback(hObject, eventdata, handles)
% hObject    handle to selector_regla_bit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selector_regla_bit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selector_regla_bit


% --- Executes during object creation, after setting all properties.
function selector_regla_bit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selector_regla_bit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in regla_ask.
function regla_ask_Callback(hObject, eventdata, handles)
% hObject    handle to regla_ask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns regla_ask contents as cell array
%        contents{get(hObject,'Value')} returns selected item from regla_ask


% --- Executes during object creation, after setting all properties.
function regla_ask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to regla_ask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in regla_fsk.
function regla_fsk_Callback(hObject, eventdata, handles)
% hObject    handle to regla_fsk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns regla_fsk contents as cell array
%        contents{get(hObject,'Value')} returns selected item from regla_fsk


% --- Executes during object creation, after setting all properties.
function regla_fsk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to regla_fsk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in regla_psk.
function regla_psk_Callback(hObject, eventdata, handles)
% hObject    handle to regla_psk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns regla_psk contents as cell array
%        contents{get(hObject,'Value')} returns selected item from regla_psk


% --- Executes during object creation, after setting all properties.
function regla_psk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to regla_psk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
