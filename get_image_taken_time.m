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