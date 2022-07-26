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

function latlon=osgbEN2osgbLatLon(E,N,max_iters)
%osgbEN2osgbLatLon Convert Northing (N), Easting (E) and optional altitude (H) on an OSGB36 ellipsoid to Latitude (osgb_phi) and Longitude (osgb_lam) on an OSGB36 ellipsoid
    if nargin < 3
        max_iters = 10;
    end
    % OSGB36 Params
    a = 6377563.396;
    b = 6356256.909;
    F_0 = 0.9996012717;
    e_squared_osgb = (a^2 - b^2)/(a^2);
    E_0 = 400000;
    N_0 = -100000;

    % positive phi: N, positive lambda: E
    phi_0 = deg2rad(49);
    lambda_0 = deg2rad(-2);

    n = (a-b)/(a+b);
    M = @(phi) b*F_0*( ...
        (1 + n + (5/4)*n^2 + (5/4)*n^3) * (phi - phi_0) ...
        - (3*n + 3*n^2 + (21/8)*n^3) * sin(phi - phi_0) * cos(phi + phi_0) ...
        + ((15/8)*n^2 + (15/8)*n^3) * sin(2*(phi - phi_0)) * cos(2*(phi + phi_0)) ...
        - (35/24)*n^3 * sin(3*(phi - phi_0)) * cos(3*(phi + phi_0)) ...
    );

    phi_prime = ((N-N_0)/(a*F_0)) + phi_0;

    test_val = N - N_0 - M(phi_prime);
    c = 0;
    while (abs(test_val) > 1e-5) && (c < max_iters)
        phi_prime = ((test_val)/(a*F_0)) + phi_prime;
        test_val = N - N_0 - M(phi_prime);
        c = c + 1;
    end
    nu = a*F_0 * (1 - e_squared_osgb*sin(phi_prime)^2)^-0.5;
    rho = a*F_0 * (1 - e_squared_osgb) * (1 - e_squared_osgb*sin(phi_prime)^2)^-1.5;
    eta_squared = (nu/rho) - 1;

    VII = tan(phi_prime)/(2*rho*nu);
    VIII = (tan(phi_prime)/(24*rho*nu^3)) * (5 + 3 * tan(phi_prime)^2 + eta_squared - 9 * (tan(phi_prime)^2) * eta_squared);
    IX = (tan(phi_prime)/(720*rho*nu^5)) * (61 + 90 * tan(phi_prime)^2 + 45 * tan(phi_prime)^4);
    X = sec(phi_prime)/nu;
    XI = (sec(phi_prime)/(6*nu^3)) * ((nu/rho) + 2 * tan(phi_prime)^2);
    XII = (sec(phi_prime)/(120*nu^5)) * (5 + 28 * tan(phi_prime)^2 + 24 * tan(phi_prime)^4);
    XIIA = (sec(phi_prime)/(5040*nu^7)) * (61 + 662 * tan(phi_prime)^2 + 1320 * tan(phi_prime)^4 + 720 * tan(phi_prime)^6);

    phi_osgb = phi_prime - VII*(E-E_0)^2 + VIII*(E-E_0)^4 - IX*(E-E_0)^6;
    lam_osgb = lambda_0 + X*(E-E_0) - XI*(E-E_0)^3 + XII*(E-E_0)^5 - XIIA*(E-E_0)^7;

    latlon = [phi_osgb,lam_osgb];
end