function num_coords=letter_grid2numbers(letters)
%letter_grid2numbers convert the first two letters of an OS Grid Ref into numbers
    OS_alphabet='ABCDEFGHJKLMNOPQRSTUVWXYZ';
    nums = num2cell(arrayfun(@(L) find(OS_alphabet==L),char(letters)));
    [a,b] = nums{:};
    X_500 = [mod(a,5) - 1, floor((25 - a)/5)];
    if mod(a,5)==0
        X_500(1) = 5-1;
    end
    X_100 = [mod(b,5) - 1, floor((25 - b)/5)];
    if mod(b,5)==0
        X_100(1) = 5-1;
    end
    transform_X_500 = [-2,-1];
    num_coords = (X_500 + transform_X_500)*5 + X_100;
end
