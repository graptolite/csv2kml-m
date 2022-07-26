% Copyright (C) 2022  Yingbo Li
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.

% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.

%% CONFIG
% name of csv file with the necessary column headers
CSV_FILE = "data.csv";

% name of the KML folder that will hold all the points of interest
KML_FOLDER_NAME = "Locations";

% name of the file the kml is written to
KML_FILE_NAME = "output.kml";

% folder that holds all the images - absolute paths are preferred for this
% if paths are provided in the csv file, set this to an empty string ""
IMG_DIR = "imgs";

% icon scale 
ICON_SCALE = 1.0;

% icon marker source
ICON_MARKER = "http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png";

% maximum number of iterations when calculating lat lon from cartesian-type
% coords
MAX_ITER = 10;

%% FUNCTION FOLDERS
addpath(genpath('kml_funcs'))
addpath(genpath('coord_funcs'))

%% SCRIPT

opts = detectImportOptions(CSV_FILE);
opts.VariableTypes = repmat({'char'},1,length(opts.VariableTypes));
df = string(readmatrix(CSV_FILE,opts));
% columns: | id | gridRef | img | desc |
n_rows = height(df);
all_placemarks = "";
for i=[1:n_rows]
    row = df(i,:);
    name = row(1);
    grid_ref = row(2);
    EN = grid_ref2osgb(grid_ref);
    H = 0; % default height to zero
    lat_lon_H = osgbEN2wgsLatLon(EN(1),EN(2),H,MAX_ITER);
    lat = lat_lon_H(1);
    lon = lat_lon_H(2);
    H = lat_lon_H(3);
    img_name = strip(row(3));
    desc = strip(row(4));
    
    if img_name ~= ""
        img_path = fullfile(IMG_DIR,img_name);
        time_taken = get_image_taken_time(img_path);
        contents = sprintf('<img src="%s" width="250px"></br></br>Time Taken: %s</br>%s', img_path,time_taken,desc);
    else
        contents = sprintf("%s",desc);
    end
    
    all_placemarks = all_placemarks + make_placemark(name,sprintf("%.15f,%.15f",lon,lat),contents,ICON_SCALE,ICON_MARKER);
end

kml = init_kml(kml_folder(KML_FOLDER_NAME,all_placemarks));

outfile = fopen(KML_FILE_NAME,"w");
fprintf(outfile,"%s",kml);
fclose(outfile);