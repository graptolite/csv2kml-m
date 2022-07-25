function latlonH=wgsCartesian2wgsLatLon(v_wgs,max_iters)
%wgsCartesian2wgsLatLon Convert Cartesian coordinates [x,y,z] (v_wgs) on a WGS84 ellipsoid to Latitude (wgs_phi) and Longitude (wgs_lam) on a WGS84 ellipsoid
    if nargin < 2
        max_iters = 10;
    end
    a = 6378137.000;
    b = 6356752.3141;
    x_wgs = v_wgs(1);
    y_wgs = v_wgs(2);
    z_wgs = v_wgs(3);

    wgs_e_squared = (a^2 - b^2)/(a^2);

    lam_wgs = atan2(y_wgs,x_wgs);
    p = (x_wgs^2+y_wgs^2)^0.5;
    phi_wgs = atan2(z_wgs,(p*(1-wgs_e_squared)));
    wgs_nu = a * (1 - wgs_e_squared*sin(phi_wgs)^2)^-0.5;
    reached_precision = false;
    c = 0;
    while ~reached_precision && (c < max_iters)
        new_phi_wgs = atan2((z_wgs + wgs_e_squared*wgs_nu*sin(phi_wgs)),p);
        wgs_nu = a * (1 - wgs_e_squared*sin(phi_wgs)^2)^-0.5;
        if abs(phi_wgs - new_phi_wgs) < 1e-30
            reached_precision = true;
        end
        phi_wgs = new_phi_wgs;
        c = c + 1;
    end
    H = (p/cos(phi_wgs)) - wgs_nu;
    latlonH = [phi_wgs,lam_wgs,H];
end