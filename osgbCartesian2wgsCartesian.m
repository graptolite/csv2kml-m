function v_wgs=osgbCartesian2wgsCartesian(v_osgb)
%osgbCartesian2wgsCartesian Convert a vector of Cartesian coordinates [x,y,z] (v_osgb) on an OSGB36 ellipsoid to a vector of Cartesian coordinates [x,y,z] (v_wgs) on a WGS84 ellipsoid
    % transformations
    t_x = -446.448;
    t_y = 125.157;
    t_z = -542.060;

    % scale
    s = 20.4894 * 1e-6;

    % rotations
    sec2rad = @(sec) deg2rad(sec*(1/3600));
    r_x = sec2rad(-0.1502);
    r_y = sec2rad(-0.2470);
    r_z = sec2rad(-0.8421);

    helmert_matrix = [1 + s, -r_z,  r_y;
                      r_z,   1 + s, -r_x;
                      -r_y,  r_x,   1 + s];

    v_t = [t_x;t_y;t_z];

    v_wgs = helmert_matrix\(v_osgb - v_t);
end
