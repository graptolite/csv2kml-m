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

function OSGB=grid_ref2osgb(grid_ref)
%grid_ref2osgb convert grid reference to (E,N) tuple
    % Note: decimals in the grid reference are not currently supported
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