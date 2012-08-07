echo "compilation..."
echo "..swfmill"
swfmill simple library.xml library.swf
echo "..matasc"
mtasc -swf library.swf -out space.swf -version 8 -main main.as -cp /usr/bin/mtasc1.1/std/ -cp ./
