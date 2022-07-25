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