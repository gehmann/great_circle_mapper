%% Great Circle Mapping Tool
% Kurt Ehmann
% AE199CS, Spring 2019
% This tool take an input of two or more airport codes from a GUI and plots
% the shortest distance between them on the globe. The distance along with 
% the route is displayed in the legend of the plot. Routes are entered into
% the GUI by entering either IATA or ICAO airport codes, separated by
% commas. A route is ended with a semicolon. There is no (theoretical)
% limit to the number of points on a route or the number of routes that can
% be plotted at once, however, the plot becomes very sluggish with more
% than ten routes displayed on it. ICAO codes evaluate faster than IATA
% codes because there is a short cut built in so the program doesn't have
% to search the whole database for a matching airport code. The airport
% database must be named "airports.mat" and in the same directory as the
% program. The GUI has options for the units, either miles, nautical miles or kilometers, an
% option to draw a new plot, and an option for the label that is used on
% the map. If the "draw new plot" radio button is unchecked, the routes
% entered will be displayed on top of any routes already on the plot.
% Drawing a new plot only displays the routes entered and the radio button
% must be checked the first time the program is run in order for a plot to
% be draw. The Label drop down allows the user to choose what label is
% used, "Name" prints the full name of the airport, "ICAO" and "IATA" print
% the corresponding codes and none does not label the airports.
%%

%% GreatCircleMapper
% Code for the GUI. Contains functions for all the buttons and inputs and
% takes those inputs and calls Great_Circle_Mapper to make the plot with
% the corresponding information. 

function varargout = GreatCircleMapper(varargin)
% GREATCIRCLEMAPPER MATLAB code for GreatCircleMapper.fig
%      GREATCIRCLEMAPPER, by itself, creates a new GREATCIRCLEMAPPER or raises the existing
%      singleton*.
%
%      H = GREATCIRCLEMAPPER returns the handle to a new GREATCIRCLEMAPPER or the handle to
%      the existing singleton*.
%
%      GREATCIRCLEMAPPER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GREATCIRCLEMAPPER.M with the given input arguments.
%
%      GREATCIRCLEMAPPER('Property','Value',...) creates a new GREATCIRCLEMAPPER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GreatCircleMapper_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GreatCircleMapper_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GreatCircleMapper

% Last Modified by GUIDE v2.5 01-May-2019 18:20:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GreatCircleMapper_OpeningFcn, ...
                   'gui_OutputFcn',  @GreatCircleMapper_OutputFcn, ...
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
end

% --- Executes just before GreatCircleMapper is made visible.
function GreatCircleMapper_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no message args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GreatCircleMapper (see VARARGIN)

% Choose default command line message for GreatCircleMapper
handles.message = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GreatCircleMapper wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = GreatCircleMapper_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning message args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line message from handles structure
varargout{1} = handles.message;
end

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
end

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input as text
%        str2double(get(hObject,'String')) returns contents of input as a double

str = get(hObject, 'String');
end


% --- Executes during object creation, after setting all properties.
function input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in maptype.
function maptype_Callback(hObject, eventdata, handles)
% hObject    handle to maptype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns maptype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from maptype
contents = cellstr(get(hObject, 'String'));
global typeOfMap;
typeOfMap = 'Bluegreen';
typeOfMap = contents{get(hObject, 'Value')};
end
% --- Executes during object creation, after setting all properties.
function maptype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maptype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in newPlot.
% Code for the "Draw new plot" radio button
function newPlot_Callback(hObject, eventdata, handles)
% hObject    handle to newPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of newPlot
global drawNewPlot;
drawNewPlot = true;
new = get(hObject, 'Value');
drawNewPlot = new;
end

% --- Executes on button press in plot ("Plot" button)
function plot_Callback(hObject, eventdata, handles)
% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = handles.input.String;
global typeOfLabel;
global drawNewPlot;
global typeOfUnit;
global typeOfMap;
route = routesFromString(str); %Convert the inputted string into a structure file in the correct format

% Main function to generate the plot
Great_Circle_Mapper(route, handles, typeOfMap, 'label', typeOfLabel, 'newfigure', drawNewPlot, 'radius', typeOfUnit);
end

% --- Executes on selection change in label.
% Code for the "Label" drop down menu
function label_Callback(hObject, eventdata, handles)
% hObject    handle to label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns label contents as cell array
%        contents{get(hObject,'Value')} returns selected item from label

contents = cellstr(get(hObject, 'String'));
global typeOfLabel;
typeOfLabel = contents{get(hObject, 'Value')}; %Get selection and set it to the global variable to be used in the plot function
end

% --- Executes during object creation, after setting all properties.
function label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --- Executes on selection change in units.
% Function for the "units" drop down menu
function units_Callback(hObject, eventdata, handles)
% hObject    handle to units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units
contents = cellstr(get(hObject, 'String'));
i = get(hObject,'Value');
global typeOfUnit;
unit = contents{i};
unit = unit(1:5);
if unit == 'Kilom' %Determine which unit is selected and set the radius to the corresponding value
    typeOfUnit = 6371;
elseif unit == 'Nauti'
    typeOfUnit = 3440.1;
else
    typeOfUnit = 3958.8;
end
end

% --- Executes during object creation, after setting all properties.
function units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

%% routesFromString
% Funcition which convertes the input string into a structure file where
% route(i) is a separate route to be plotted for each i and
% route(i).airports(j) is airport j in route i. 
%Ex. for the input: "KORD, KSFO; KORD, KLAX;"
%route(2).airports(1) = 'KORD'
%Accepts a string and returns a structure file

function [route] = routesFromString(str)
    route(1).airports(1) = " "; %Set up variables and initial values
    prev = 1;
    j = 1;
    k = 1;
    comma = 0;
    semi = 0;
    str= str(find(~isspace(str))); %Remove all the spaces from the input string
    
    for i = 1:length(str) %Loop to cycle through each character in the string...
                          %and put the codes in the input into the correct place in the routes structure file
        if str(i) == ',' || str(i) == ';' || str(i) == '-'
            s = str(prev:i-1);
            s = convertCharsToStrings(s);
            route(j).airports(k) = s;
            prev = i+1;
            k = k + 1;
            comma = comma + 1;
        end
        if str(i) == ';'
            j = j + 1;
            k = 1;
            semi = semi + 1;
            if i ~= length(str)
                if str(i+1) == ' '
                    prev = prev + 1;
                end
            end
        end
    end
    if comma == 1 || comma == 0
        errordlg(strcat('Error: Please enter at least two codes.'))
    end
    if str(length(str)) ~= ';'
        errordlg(strcat('Error: The Statment must end with a semicolon.'))
    end
    route;
        
end

%% Great_Circle_Mapper
% Main funtion that accepts the route structure and calls the "Mapper"
% funtion to create the plots for each route
% Inputs: route: 
    % Structure file containing airports
% Optional Inputs: 
    %'newFigure': Boolean, True to draw a new figure, False
        % to keep the current figure.
    %'label': Char array that control the label put on the figure. Accepted
        % values: 'None', 'ICAO', 'IATA', 'Name'. Parameter is case insensitive
    % 'color': To be used in future version to control color of routes
    % 'radius': Numeric value for the radius of the Earth. Accepts 6371 for
        %kilometers, 3440.1 for nautical miles and 3958.8 for miles

 function Great_Circle_Mapper(route, handles, map, varargin)
    process = inputParser;
    
    addRequired(process, 'route', @isstruct);
    
    process.PartialMatching = false;
    
    addParameter(process, 'newfigure', @islogical); %Code for optional parameters
    addParameter(process, 'label', @ischar);
    addParameter(process, 'color', @isarray);
    addParameter(process, 'radius', @isnumeric);
    
    parse(process,route,varargin{:});
    
    process = process.Results;    

    process.newfigure;
    class(process.newfigure);
    newFig = (given(process.newfigure)); %Find if new figure parameter is given
    if process.newfigure == false;
        figure(1) %If new figure is not requested, switch to figure 1
        if strcmp("Satellite", map)
            textColor = 'w';
        else
            textColor = 'k';
        end
    else %Create new figure if feature is requested
        figure(1)
        clf
        textColor = 'k';
        map = convertCharsToStrings(map);
        mapType = "bluegreen";
        if strcmp("Bluegreen", map)
            mapType = 'bluegreen';
        elseif strcmp("Satellite", map)
            mapType = 'USGS';
            textColor = 'w';
        elseif strcmp("Land Cover", map)
            mapType = 'landcover';
        elseif strcmp("Color Terrain", map)
            mapType = 'colorterrain';
        elseif strcmp("Gray Land", map)
            mapType = 'grayland';
        elseif strcmp("Gray Terrain", map)
            mapType = 'grayterrain';
        elseif strcmp("Dark Water", map)
            mapType = 'darkwater';
        elseif strcmp ("Open Street Map", map)
            mapType = 'Street';
        end

        baseURL = "https://basemap.nationalmap.gov/ArcGIS/rest/services"; %Fetch USGS satellite map
        usgsURL = baseURL + "/USGSImageryOnly/MapServer/tile/${z}/${y}/${x}";
        maxZoomLevel = 16;
        addCustomBasemap("USGS", usgsURL, 'Attribution', 'USGS', 'DisplayName', 'USGS', 'MaxZoomLevel', maxZoomLevel);
        
        url = 'a.tile.openstreetmap.org'; %Fetch Open Street Maps map  
        addCustomBasemap("Street", url, 'Attribution', 'Open Street Map', 'DisplayName', 'Open Street Map', 'MaxZoomLevel', maxZoomLevel);
        
        geobasemap(mapType) %Plot geo map

        set(0, 'units', 'pixels')   %Set window size and position, Code by Dean Romanchek 
        Pix_SS = get(0, 'screensize'); 
        p = [Pix_SS(3), Pix_SS(4)];
        q = [.75*p(1), .75*p(2)];
        pos = (p-q)./2;
        set(gcf, 'Position', [pos, q]);

        legend show %show and locate legend to the right of the figure
        legend('location', 'eastoutside')
    end
    
    doLabel = givenChar(process.label); %Find if label optional parameter is given
    labelNum = ' ';
    
    if doLabel
        labelNum = upper(process.label); %If given, set labelNum to given value
    end
                
    doRad = givenNum(process.radius); %Find if radius optional parameter is given
    rad = 3958.8;  
    unit = ' mi'; %Default unit is miles
    if process.radius ~= 0
        rad = process.radius; %If given, set radius to correct value
        if rad == 6371
            unit = ' km';
        elseif rad == 3440.1
            unit = ' nm';
        end
    end       
    for i = 1:length(route(:))
        Mapper(route(i).airports, i, labelNum, rad, unit, handles, textColor); %Call "Mapper" function once for each route
    end
end

%% Mapper
% Inputs:
% airport: array of airport codes
% color: Number of color to plot route in
% labelNum: Char array that corresponds to which label type to plot,
    % 'ICAO', 'IATA', 'NAME', 'NONE'
% radius: 6371 for kilometers, 3963 for miles, 3440.1 for nautical miles
% unit: text to be displayed as unit

function Mapper(airport, color, labelNum, radius, unit, handles, textColor)
    

    for i = 1:length(airport) %Convert all codes to uppercase and strings
        airport(i) = upper(airport(i));
        str = convertStringsToChars(airport(i));
        
        [place(i), lat(i), long(i), name(i), icao(i), iata(i)] = findInfo(str, handles) %Parse through the file to find the information that goes with the inputted airport code
        
    end
    
    cart = degToCart(lat, long, radius); %Use degToCart to find the cartesian coordinates of the airport from the latitude and longitude
    
    for j = 1:length(cart(:,1))-1
        [path(j).points, path(j).distance] = findPath(cart,j, radius); %Use findPath to find the path between the airports
    end
       
    paths = cartToLatLong(path); %Convert the cartesian coordinates back to latitude and longitude
    label = false;
    if labelNum == 'NONE' %Based on label type requested, call makePlot with the correct label input
        label = false;
        makePlot(paths, color, name, lat, long, label, path, unit, textColor);
    elseif labelNum == 'ICAO'
        label = true;
        makePlot(paths, color, icao, lat, long, label, path, unit, textColor);
    elseif labelNum == 'IATA'
        label = true;
        makePlot(paths, color, iata, lat, long, label, path, unit, textColor);
    elseif labelNum == 'NAME'
        label = true;
        makePlot(paths, color, name, lat, long, label, path, unit, textColor);
    else
       label = true;
       makePlot(paths, color, icao, lat, long, label, path, unit, textColor); %Default label is ICAO
    end
    
end

%% findInfo
% Takes an inputted char array in IATA or ICAO and finds its entry in
% airports.mat and returns its information
% Inputs:
    %str: char array containing either IATA or ICAO airport code
% Outputs:
    %place: index of the airport in airports.mat
    %lat: latitude of airport
    %long: longitude of airport
    %Name: name of airport
    %icao: ICAO code of airport
    %iata: IATA code of airport

function [place, lat, long, name, icao, iata] = findInfo(str, handles)

    i = 1; %Initialize stepper variables
    place = 0;
    load('airports.mat'); %Load airport data file
    s = size(airports(:,1)); %Find length of the file
    
    if length(str) > 3 %If an ICAO code is given jump to the specified index, makes parsing the file significantly faster
        if str(1) == '0'
            i = 1;
        elseif str(1) == '1'
            i = 1190;
        elseif str(1) == '2'
            i = 2380;
        elseif str(1) == '3'
            i = 3640;
        elseif str(1) == '4'
            i = 4730;
        elseif str(1) == '5'
            i = 5730;
        elseif str(1) == '6'
            i = 6730;
        elseif str(1) == '7'
            i = 7670;
        elseif str(1) == '8'
            i = 8580;
        elseif str(1) == '9'
            i = 9440;
        elseif str(1) == 'A'
            i = 10320;
        elseif str(1) == 'B'
            i = 12070;
        elseif str(1) == 'C'
            i = 12920;
        elseif str(1) == 'D'
            i = 16800;
        elseif str(1) == 'E'
            i = 17630;
        elseif str(1) == 'F'
            i = 19720;
        elseif str(1) == 'G'
            i = 21780;
        elseif str(1) == 'H'
            i = 22790;
        elseif str(1) == 'I'
            i = 23340;
        elseif str(1) == 'J'
            i = 24970;
        elseif str(1) == 'K'
            i = 25140;
        elseif str(1) == 'L'
            i = 30560;
        elseif str(1) == 'M'
            i = 32640;
        elseif str(1) == 'N'
            i = 35500;
        elseif str(1) == 'O'
            i = 37110;
        elseif str(1) == 'P'
            i = 38100;
        elseif str(1) == 'Q'
            i = 39450;
        elseif str(1) == 'R'
            i = 39450;
        elseif str(1) == 'S'
            i = 40770;
        elseif str(1) == 'T'
            i = 47570;
        elseif str(1) == 'U'
            i = 48470;
        elseif str(1) == 'V'
            i = 50670;
        elseif str(1) == 'W'
            i = 51650;
        elseif str(1) == 'X'
            i = 52580;
        elseif str(1) == 'Y'
            i = 52810;
        elseif str(1) == 'Z'
            i = 54640;
        else 
            i = 1;
        end
    end
        
    if length(str) == 3 %If the code is IATA, search that column of the file
        i = 1;
        while i <= s(1)
            if strcmp(airports.iata_code(i), str)
                place = i;
                break;
            end
            i = i + 1;
            if i > s
               %set(handles.edit4, 'String', 'ERROR: Code not found')
               errordlg(strcat('Error:  ', str, ' not found'))
               break;
            end
        end
    else %Otherwise search ICAO column
        while i <= s(1)
            if strcmp(airports.ident(i), str)
                place = i;
                break;               
            end
            i = i + 1;
            if i > s
                %set(handles.edit4, 'String', 'ERROR: Code not found')
                errordlg(strcat('Error:  ', str, ' not found'))
                break;
            end
        end
    end

    place; % Return variables
    lat = airports.latitude_deg(i);
    long = airports.longitude_deg(i);
    name = airports.name(i);
    icao = airports.ident(i);
    iata = airports.iata_code(i);
    

end

%% degToCart
% Take inputted latitude, longitude and radius arrays and find those points
% in cartesian coordinates
% Inputs:
    %lat: array with latitudes of points
    %long: array with longitudes of points
    %r: radius of the earth in chosen units

function [cart] = degToCart(lat, long, r)

    for i = 1:length(lat)
        cart(i, 1) = r*cosd(long(i))*sind(90-lat(i)); %X
        cart(i, 2) = r*sind(long(i))*sind(90-lat(i)); %Y
        cart(i, 3) = r*cosd(90-lat(i)); %Z
    end

    cart;

end

%% findPath
% Find shortest path between two points on the globe
% Inputs:
    %cart: 2D array of cartesian coordiantes for the points
    %start: Index of the cart array to use as the starting point
    %r: Radius of the earth in chosen units
% Outputs:
    %points: array of points on the path, .1 degree apart, in cartesian
    %distance: distance of the shortest path on the globe between the start
    %and end points
function [points, distance] = findPath(cart, start, r)

    en = start + 1; %End index
    
    s = cart(start,:); %Find start vector
    
    e = cart(en,:); %Find end vector
    
    n = cross(s, e); %Find vector normal to the start and end vector
    
    I = s./norm(s); %Defining new basis based on the start and normal vectors
    K = n./norm(n);
    J = cross(K, I);
    
    B = [I;J;K]; %Matrix for new basis in terms of standard cartesian basis
    b = B'; %Inverse, used to convert back to standard cartesian
    
    s = s'; %Convert to column vectors for matrix multiplication
    e = e';
    
    S = B*s; %Convert start vector to new basis
    
    E = B*e; %Convert end vector to new basis
    
    theta = acosd(dot(S,E)/(norm(S)*norm(E))); %Find angle between the start and end points
    
    distance = r*theta*(pi/180); %Compute distance of the great circle path
    
    i = 0; %Initialize stepper variables
    j = 1;
    p = zeros(3, 20);
    
    
    while i < theta %Change the angle between the start and end vector by .1 degrees each time and find the new vector
        p(:,j) = [S(1)*cosd(i); S(1)*sind(i); 0];        
        i = i + .1;
        j = j + 1;
    end
    
    for k = 1:length(p(1,:))
        points(:,k) = b*p(:,k); %Convert points back to the standard cartesian basis
    end
    points;
end
    
%% cartToLatLong
% Converts cartesian coordinates to latitude and longitude
%Inputs:
    %cart: array of cartesian coordinates
%Outputs:
    %sph: coordinates in latitude and longitude

function [sph] = cartToLatLong(cart)

    d = length(cart(:)); %Find length of cartesian array

    for j = 1:d %Steps through all values and converts the points to back to latitude and longitude
        for i = 1:length(cart(j).points(1,:))

            x = cart(j).points(1,i);
            y = cart(j).points(2,i);
            z = cart(j).points(3,i);

            r = [x,y,z];

            lat = acosd(z/norm(r));

            R = norm(r);

            long = atan2(y,x);

            long = long*(180/pi);

            sph(j).points(1,i) = R;
            sph(j).points(3,i) = 90-lat;
            sph(j).points(2,i) = long;

        end
    end

    sph;
    
end

%% makePlot
% Takes input variables and creates a plot
%Inputs:
    %path: structure file containing points to plot at path.points
    %routeColor: number that corresponds to color to plot route in
    %airport: char array of desired label of the airports
    %lat: array of latitudes of the airports
    %long: array of longitudes of the airports
    %label: boolean, whether or not to display a label
    %paths: structure containing the distances at paths.distance
    %unit: char array of unit label

function makePlot(path, routeColor, airport, lat, long, label, paths, unit, textColor)    
    
    color = 'k'; %Default color is black
    routeColor = mod(routeColor,7);
    switch routeColor %Select color based on number given
        case 1
            color = 'r';
        case 2
            color = 'b';
        case 3 
            color = 'g';
        case 4 
            color = 'y';
        case 5 
            color = 'm';
        case 6 
            color = 'c';
        case 7 
            color = 'k';
    end
    
    d = length(path(:));
    plot1 = false; %Initialize variables
    k = 1;
    crossingPacific = false;
    for i = 1:d
        for l = 1:length(path(i).points(2,:))-1 %Parse through all the longitudes and if the difference is big, the path must cross the Pacific
            f = l+1;
            if abs((path(i).points(2,l))-(path(i).points(2,f))) > 5
                crossingPacific = true;
            end
        end
        if crossingPacific %If the route is crossing the Pacific, points with longitude between 90 and 180 have 360 subtracted from them so the route is continuous. 
            for l = 1:length(path(i).points(2,:)) 
                f = l+1;
                if path(i).points(2,l) >= 90 && path(i).points(2,l) <= 180
                    path(i).points(2,l) = path(i).points(2,l) - 360;
                end
            end
            if path(i).points(2,length(path(i).points(2,:))) <= -180 && path(i).points(2,length(path(i).points(2,:))) >= -270 %Change coordinates so the label goes in the correct place. 
                    long(i+1) = long(i+1) - 360;
            end
            if path(i).points(2,length(path(i).points(2,1))) <= -180 && path(i).points(2,length(path(i).points(2,1))) >= -270
                    long(i) = long(i) - 360;
            end
        end        
        x = path(i).points(2,:);
        x(length(x) + 1) = long(i+1); %Make sure end point is included
        y = path(i).points(3,:);
        y(length(y) + 1) = lat(i+1);
        hold on;
        geoplot(y, x,'color', color, 'LineWidth', 2, 'DisplayName', strcat(convertCharsToStrings(airport(k)),...
            '\rightarrow', convertCharsToStrings(airport(k+1)), sprintf('\n%.2f', paths(k).distance), unit))
        k = k + 1;
    end   
    if label %Label the points on the path
        for j = 1:length(airport)
            s = strcat('\leftarrow', ' ', airport(j));
            text(lat(j), long(j), s, 'color', textColor)
        end
    end
        
end

%% given/givenChar/givenNum
% Find if a optional parameter is given or not, original function by Dean
% Romanchek
function [bool] = given(OptionalParameter)
    bool = isa(OptionalParameter,'logical');
end

function [bool] = givenChar(OptionalParameter)
    bool = isa(OptionalParameter,'char');
end

function [bool] = givenNum(OptionalParameter)
    bool = isa(OptionalParameter,'numeric');
end
