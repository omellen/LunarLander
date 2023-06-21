//these variables determine the position of the fuel meter relative to the size of the camera
//that way we can keep its position on the screen consistent when we zoom the camera in or out
//the number multiplied by the camera width/height is 1 divided by the quotient of the width/height 
//and the desired amount of pixels from the left or top of the camera
//Ex. we want the healthbar 20 pixels from the left of the screen, so the camera width (1300) divided by 20 is 65
//we then multiply the camera width/height by 1/65
draw_set_color(c_white);
var healthbarWidth = (1/65) * camera_get_view_width(view_camera[0]);
var healthbarHeight = (1/9) * camera_get_view_height(view_camera[0]);
var healthBarDistanceFromLeft = (1/130) * camera_get_view_width(view_camera[0]);
var healthBarDistanceFromTop = (1/35) * camera_get_view_height(view_camera[0]);

//draw our healthbars with the above var
draw_healthbar(camera_get_view_x(view_camera[0]) + healthBarDistanceFromLeft, 
camera_get_view_y(view_camera[0]) + healthBarDistanceFromTop, 
camera_get_view_x(view_camera[0])+ healthBarDistanceFromLeft + healthbarWidth, 
camera_get_view_y(view_camera[0]) + healthBarDistanceFromTop + healthbarHeight, 
fuel, c_black, c_red, c_lime, 3, true, true);

//same thing with the position of the fuel meter label
var fuelTextDistanceFromTop = (1/6.9) * camera_get_view_height(view_camera[0]);

//and the speed lablels
var speedTextDistanceFromLeft = (1/18.6) * camera_get_view_height(view_camera[0]);
var hSpeedTextDistanceFromTop = (1/15) * camera_get_view_height(view_camera[0]);

//and the score label
var scoreTextDistanceFromLeft = (1-(1/10)) * camera_get_view_width(view_camera[0]);

//we want our font size to match whether or not the camera is zoomed in or out
switch(objCamera.zoomedIn){
	case 0:
		//large font for zoome out
		draw_set_font(ftTypewriterLarge);
		break;
	case 1:
		//smaller font for zoomed in
		draw_set_font(ftTypewriterSmall);
		break;
}

//draw our labels with the variables calculated above
draw_text(camera_get_view_x(view_camera[0]) + healthBarDistanceFromLeft, 
camera_get_view_y(view_camera[0]) + fuelTextDistanceFromTop, "FUEL");
draw_text(camera_get_view_x(view_camera[0]) + speedTextDistanceFromLeft, 
camera_get_view_y(view_camera[0]) + healthBarDistanceFromTop, "VERTICAL SPEED: " + string(vspeed));
draw_text(camera_get_view_x(view_camera[0]) + speedTextDistanceFromLeft, 
camera_get_view_y(view_camera[0]) + hSpeedTextDistanceFromTop, "HORIZONTAL SPEED: " + string(hspeed));
draw_text(camera_get_view_x(view_camera[0]) + scoreTextDistanceFromLeft, 
camera_get_view_y(view_camera[0]) + healthBarDistanceFromTop, "SCORE: " + string(score));

//create variables for the text on the game over screen and that text's x position in relation to camera width (like above)
var rewardStatement = "placeholder text";
var xFactor = 0;
//check if the player has landed
if(landed){
	//set the font size to large
	draw_set_font(ftTypewriterLarge);
	//check the type of landing
	if(landing=="crash"){
		//if the player crashed, change the variables accordingly
		xFactor = 2.4;
		rewardStatement = "YOU CRASHED";
	}else if(landing=="miss"){
		//if the player missed the target, change the variables accordingly
		xFactor = 2.95;
		rewardStatement = "YOU MISSED THE TARGET!";
	}else if(landing=="success"){
		//if the player landed on the target successfuly, change the variables accordingly
		xFactor = 2.55;
		rewardStatement = "MISSION SUCCESS!";
	}
		//draw the game over text using the above variables	
		draw_text(camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0])/xFactor), 
		camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0])/8.75), rewardStatement);
		draw_text(camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0])/2.5), 
		camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0])/6.5), "FINAL SCORE: " + string(score));
		draw_text(camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0])/3.05), 
		camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0])/5.15), "PRESS SPACE TO TRY AGAIN");
}

//remember to draw the ship too
draw_self();
