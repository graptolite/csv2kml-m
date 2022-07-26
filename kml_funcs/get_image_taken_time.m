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

function time=image_taken_time(img_path)
%image_taken_time retrieve time an image was taken
try
    timestamp = split(imfinfo(img_path).DateTime," ");
    year_month_day = split(timestamp(1),":");
    day_month_year = flip(year_month_day);
    hour_min_sec = split(timestamp(2),":");
    time = join(day_month_year,"/") + " " + join(hour_min_sec,":");
catch
    time = "";
end
end