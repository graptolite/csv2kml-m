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

function xml=make_xml(tag_nest,contents)
    function tag=xml_tag_str(tag,contents)
        %tag_str return the contents within an xml-style tag
            % *tag* can be the tag by itself or tag with attributes separated by a
            %       space from the tag e.g. tag="div style=\"color:grey;\""
        split_tag = split(tag," ");
        just_tag = string(split_tag(1));
        contents = string(contents);
        tag=sprintf("<%s>\n%s\n</%s>",tag,contents,just_tag);
    end
    if length(tag_nest)==1
        xml = xml_tag_str(tag_nest,contents);
    else
        xml = make_xml(tag_nest(1:end-1),xml_tag_str(tag_nest(end),contents));
    end
end