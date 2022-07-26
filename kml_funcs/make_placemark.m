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

%%

function kml=make_placemark(name,coordinates,description,icon_scale,icon_marker)
kml = make_xml("Placemark",...
               make_xml("name",name)+...
               make_xml("description",make_CDATA(description))+...
                   make_xml(["Style","IconStyle"],...
                       make_xml("scale",icon_scale)+...
                       make_xml(["Icon","href"],icon_marker))+...
                   make_xml(["Point","coordinates"],coordinates));                            
end