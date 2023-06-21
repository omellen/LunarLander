
//this function will set the color
//of the mountains
draw_set_color(c_dkgray);
for (var xPos=screenLeft; xPos<screenRight; xPos++) {
	var readIndex = xPos + midPointer;
	var height = perlin[readIndex]+150;
	draw_rectangle(xPos, height, xPos + resolution, screenBottom, false);	
}



