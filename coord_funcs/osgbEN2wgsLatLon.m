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

% REFERENCE FOR MATHS: A Guide to Coordinate Systems in Great Britain
% V3.6 © OS 2020 (original Copyright Ordnance Survey 2018)
% https://www.ordnancesurvey.co.uk/documents/resources/guide-coordinate-systems-great-britain.pdf

%%

function deg_latlonH=osgbEN2wgsLatLon(E,N,H,max_iters)
%osgbEN2wgsLatLon Convert Northing (N), Easting (E) and altitude (H) on an OSGB36 ellipsoid to Latitude (osgb_phi) and Longitude (osgb_lam) on an OSGB36 ellipsoid
    latlon = osgbEN2osgbLatLon(E,N,max_iters);
    phi_osgb = latlon(1);
    lam_osgb = latlon(2);

    v_osgb = osgbLatLon2osgbCartesian(phi_osgb,lam_osgb,H);
    v_wgs = osgbCartesian2wgsCartesian(v_osgb);

    latlonH = wgsCartesian2wgsLatLon(v_wgs,max_iters);
    deg_latlonH = [rad2deg(latlonH(1)),rad2deg(latlonH(2)),latlonH(3)];
end