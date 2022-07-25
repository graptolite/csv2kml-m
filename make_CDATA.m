function cdata=make_CDATA(contents)
if nargin<1
    contents="";
end
cdata=sprintf("<![CDATA[\n%s\n]]>",string(contents));
end