function OSGB=grid_ref2osgb(grid_ref)
%grid_ref2osgb convert grid reference to (E,N) tuple
    % Note: decimals in the grid reference are not currently supported
    grid_ref = char(grid_ref);
    letters = grid_ref(1:2);
    X_pre = string(letter_grid2numbers(letters));
    numbers = strip(grid_ref(3:end));
    if isempty(numbers)
        raw_X = ["",""];
        raw_E = "";
        raw_N = "";
    else
        raw_X = strsplit(numbers," ");
        raw_E = raw_X{1};
        raw_N = raw_X{2};
        if length(raw_E) > 5 || length(raw_N) > 5
            error("Each number in the numerical part of the grid reference must have 5 or less digits, with no decimal digits.")
        end
    end
    
    function za=zeros_append(raw)
        if raw ~= ""
            za = repmat('0',1,int8(5-length(raw)));
        else
            za = "00000";
        end
    end

    E_zeros_append = zeros_append(raw_E);
    N_zeros_append = zeros_append(raw_N);
    X_zeros_append = [{E_zeros_append},{N_zeros_append}];
    
    OSGB = arrayfun(@(n) double(int32(str2double(n))),X_pre + raw_X + X_zeros_append);
end