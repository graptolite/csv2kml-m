function kml=init_kml(contents)
contents = string(contents);
kml=make_xml(['kml xmlns="http://www.opengis.net/kml/2.2"',
    "Document"],contents);
end
