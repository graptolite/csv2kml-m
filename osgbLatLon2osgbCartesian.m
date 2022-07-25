function v_osgb=osgbLatLon2osgbCartesian(phi_osgb,lam_osgb,H)
%osgbLatLon2osgbCartesian Convert Latitude (phi_osgb) and Longitude (lam_osgb) on an OSGB36 ellipsoid to a vector of Cartesian coordinates [x,y,z] (v_osgb) on an OSGB36 ellipsoid
    if nargin < 3
        H = 0;
    end
    a = 6377563.396;
    b = 6356256.909;

    e_squared_osgb = (a^2 - b^2)/(a^2);
    nu_osgb = a * (1 - e_squared_osgb*sin(phi_osgb)^2)^-0.5;

    x_osgb = (nu_osgb + H) * cos(phi_osgb) * cos(lam_osgb);
    y_osgb = (nu_osgb + H) * cos(phi_osgb) * sin(lam_osgb);
    z_osgb = ((1-e_squared_osgb)*nu_osgb + H) * sin(phi_osgb);

    v_osgb = [x_osgb;y_osgb;z_osgb];
end