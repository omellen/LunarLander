//check if the player has landed yet upon collision
if(!landed){
	//check if the the landing meets the conditions for a crash (too fast of wrong angle)
	if(speed>1.75 || !(image_angle<=30 && image_angle>=-30)){
		//uncomment the below line to make tweaking the crash criteria easier, disregard otherwise
		//show_debug_message(string(speed) + " " + string(image_angle) + " "  + string(fuel));
		//crash the ship
		crash(x, y);
		image_index = 1;
		landed = true;
		landing = "crash";
		audio_play_sound(sndCrash, 6, false);
	}else{
		//don't crash, but change the ship's conditions nonetheless
		landed = true;
		landing = "miss";
	}
}

//essentially "turn off" the ship's "physics" at this point
gravity = 0;
hspeed = 0;
vspeed = 0;
canOperate = false;

audio_stop_sound(sndThruster);
audio_stop_sound(sndLowFuel);