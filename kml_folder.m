function kml=kml_folder(name,contents)
name = string(name);
contents = string(contents);
kml = make_xml("Folder",make_xml("name",name)+contents);
end