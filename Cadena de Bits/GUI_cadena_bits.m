function varargout = GUI_cadena_bits(varargin)
% GUI_CADENA_BITS MATLAB code for GUI_cadena_bits.fig
%      GUI_CADENA_BITS, by itself, creates a new GUI_CADENA_BITS or raises the existing
%      singleton*.
%
%      H = GUI_CADENA_BITS returns the handle to a new GUI_CADENA_BITS or the handle to
%      the existing singleton*.
%
%      GUI_CADENA_BITS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CADENA_BITS.M with the given input arguments.
%
%      GUI_CADENA_BITS('Property','Value',...) creates a new GUI_CADENA_BITS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_cadena_bits_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_cadena_bits_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_cadena_bits

% Last Modified by GUIDE v2.5 31-Jan-2020 10:58:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_cadena_bits_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_cadena_bits_OutputFcn, ...
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


% --- Executes just before GUI_cadena_bits is made visible.
function GUI_cadena_bits_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_cadena_bits (see VARARGIN)

% Choose default command line output for GUI_cadena_bits
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_cadena_bits wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_cadena_bits_OutputFcn(hObject, eventdata, handles) 
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
texto = get(handles.txt,'string'); 
regla_bit_alto = str2num(get(handles.regla,'string'));

%-------- PREOCESS ---------
ascii = double(texto);
bits = dec2bin(ascii); 
cadena = reshape(bits',1,[]); 

tb = 100; % Time_bit
uno = ones(1,tb); 
cero = zeros(1,tb);
frame = [];
frameInv = [];

for n=1:length(cadena)
    if(cadena(n)=='1')
        frame = [frame uno];
        frameInv = [frameInv cero]
    else
        frame = [frame cero];
        frameInv = [frameInv uno]
    end
end

if(regla_bit_alto==1)
    cadenaBits = 5*frame;
else
    cadenaBits = 5*frameInv;
end

%--------- OUTPUT ----------
fprintf('Texto: %s\n', texto)
ascii
cadena

axes(handles.axes1)
plot(frame)
xticks(0:tb:length(frame))
axis([0 length(frame) -1 2])
grid on 
title('Señal Binaria')

axes(handles.axes2)
plot(cadenaBits)
xticks(0:tb:length(frame))
axis([0 length(cadenaBits) -1 6])
grid on
title('Cadena de Bits')
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function txt_Callback(hObject, eventdata, handles)
% hObject    handle to txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt as text
%        str2double(get(hObject,'String')) returns contents of txt as a double


% --- Executes during object creation, after setting all properties.
function txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function regla_Callback(hObject, eventdata, handles)
% hObject    handle to regla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of regla as text
%        str2double(get(hObject,'String')) returns contents of regla as a double


% --- Executes during object creation, after setting all properties.
function regla_CreateFcn(hObject, eventdata, handles)
% hObject    handle to regla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
