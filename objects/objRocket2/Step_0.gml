//slow the horizontal speed over time
hspeed *=.998;

//set limits for the ship's x values so it doesn't fly beyond view of the camera
x = clamp(x, 450, 3450);

//if the player has not started yet, pressing left, right, or up will start the game
if((!started)&&(keyboard_check(vk_right)||keyboard_check(vk_left)||keyboard_check(vk_up))){
	started = true;
	gravity = 0.05;
	canOperate = true;
}

//only allow the player to control the ship if the ship can operate
if(canOperate){
	//is the angle of the ship between -90 and 90?
	if(image_angle>=-90 && image_angle<=90){
		//if so, is the player pressing the right arrow key?
		if(keyboard_check(vk_right) && image_angle!=90){
			//rotate the angle and make the ship move horizontally, expending fuel
			image_angle+=rotationSpeed;
			if(hspeed>-3){
				hspeed-=.1;
			}
			fuel-=0.05;
		} 
		//is the player pressing the left arrow key?
		if(keyboard_check(vk_left) && image_angle!=-90){
			//rotate the angle and make the ship move horizontally, expending fuel
			image_angle-=rotationSpeed;
			if(hspeed<3){
				hspeed+=.1;
			}
			fuel-=0.05;
		} 
	}
	//limit the vertical speed of the ship to 2.5 so it doesn't move too fast
	if(vspeed>2.5){
		vspeed = 2.5;
	}
	//is the player pressing the up arrow key?
	if(keyboard_check(vk_up)){
		//generate particles, but use a random number to limit them so it doesn't spawn too many
		if(irandom_range(1,2)==2){
			instance_create_layer(x, y, "Instances", objSpark);
		}
		//make the ship move upwards while expending fuel
		if(vspeed>-8){
			vspeed-=.08;
		}
		fuel-=0.1;
		audio_play_sound(sndThruster, 2, true);
	} else {
		audio_stop_sound(sndThruster);
	}
	//limit the horizontal speed of the ship to 3 so it doesn't move too fast
	if(hspeed>3){
		hspeed = 3;
	}
}

//check if the ship is close to the ground
if(collision_circle(x, y, 100, objTracer, false, true)){
	//if it is, zoom in the camera
	objCamera.zoomedIn=1;
}else{
	//if not, keep the camera zoomed out
	objCamera.zoomedIn=0;
}
if(fuel<0){
	//when the ship runs out of fuel, make it inoperable
	audio_play_sound(sndLowFuel, 10, true);
	fuel=0;
	canOperate = false;
}