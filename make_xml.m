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