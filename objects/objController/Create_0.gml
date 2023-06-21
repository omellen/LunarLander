 //creates an array of perlin noise
perlin = [];
midPointer = 4000;

//for loop that adds perlin noise to array
for (var i=0; i<8000; i++) {
		var midNoise = perlinNoise(i*0.016,6,2);
		perlin[i] = midNoise * 500 + 300;
}




//manual entry of room size
screenBottom = room_height;
screenLeft = 0;
screenRight = room_width;
resolution = 1;

//creates the mountain
//draws each rectangle from the perlin noise down to
//the bottom of the screen for every x

// for each x on the screen
// determines the height of perlin noise
// and creates a collision layer
// which is objTracer
//draw_set_colour(c_black);
for (var xPos=screenLeft; xPos<screenRight; xPos++) {
	var readIndex = xPos + midPointer;
	var height = perlin[readIndex]+150;
	//draw_rectangle(xPos, height, xPos + resolution, screenBottom, false);	
	tracer = instance_create_layer(xPos, height, "ground", objTracer);
}

//this will find the local minimumsa and maximums
//the first few lines find three points: the current x, the x max pixels away, and the one in between
//the first if statment look to see if the current x < second > third
//if this is true, the code has found a maximum and will create a landing pad there
// if this isn't true, it will move on and see if there is a minimum and create a landing pad there
//if there is a max/min, we skip foward x amount of pixels, 
//if not, we move forward one

for(var xPos=screenLeft; xPos<screenRight; xPos++)  {
	maxX = 30;
	var readIndex = xPos + midPointer;

	var height = perlin[readIndex]+150;
	secondHeight = perlin[readIndex + maxX/2]+150;
	var thirdHeight = perlin[readIndex + maxX]+150;

	if (height <secondHeight) {
		if (secondHeight > thirdHeight) {
		num = instance_create_layer(xPos, secondHeight + 6, "landingPads", objLandingText);
		//assign point values to the different landing zones based on their heights
		//change the labels of the text beneath each landing pad by adjusting their image indexes
		if(secondHeight > 630) {
			num.image_index = 0;
		} else if (secondHeight > 600) {
			num.image_index = 1;
		} else {
			num.image_index = 2;
		}

		for (i = 0; i < maxX - 1; i++) {
			currentIndex = xPos + i + midPointer;
			currentHeight = perlin[currentIndex] + 150;
			landingPad = instance_create_layer(xPos + i, currentHeight, "landingPads", objLandingPad);
			//set the landing pad's point value according to the image index of the point label (as determined above),
			//in multiples of 15
			//2x should give 30 points, 3x should give 45, and 4x should give 60
			switch(num.image_index){
				case 0:
					landingPad.pointValue = 30;
					break;
				case 1:
					landingPad.pointValue = 45;
					break;
				case 2:
					landingPad.pointValue = 60;
					break;
			}
		}
		xPos += 100;
		}
	} else if (height > secondHeight) {
		if (secondHeight < thirdHeight) {
			num = instance_create_layer(xPos, secondHeight + 10, "landingPads", objLandingText);
			//assign point values to the different landing zones based on their heights
			//change the labels of the text beneath each landing pad by adjusting their image indexes
			if(secondHeight > 630) {
				num.image_index = 0;
			} else if (secondHeight > 600) {
				num.image_index = 1;
			} else {
				num.image_index = 2;
			}
			for (i = 0; i < maxX - 1; i++) {
				currentIndex = xPos + i + midPointer;
				currentHeight = perlin[currentIndex] + 150;
				landingPad = instance_create_layer(xPos + i, currentHeight, "landingPads", objLandingPad);
				//set the landing pad's point value according to the image index of the point label (as determined above),
				//in multiples of 15
				//2x should give 30 points, 3x should give 45, and 4x should give 60
				switch(num.image_index){
					case 0:
						landingPad.pointValue = 30;
						break;
					case 1:
						landingPad.pointValue = 45;
						break;
					case 2:
						landingPad.pointValue = 60;
						break;
				}
			}
			xPos += 100;
		}
	}

}