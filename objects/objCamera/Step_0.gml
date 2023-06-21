//check if the camera is zoomed out
if(zoomedIn==0){
	//if so, set it the view port accordingly
	view_camera[0] = cameraZoomedOut;
	//allow the player to "push" the camera left and right by approaching the edge of the screen
	if(objRocket2.x < 3450 && objRocket2.x > 450){
		if(objRocket2.x > zoomedOutCenteredX + 450 && objRocket2.hspeed>0){
			//move the camera according to the player's horizontal speed
			camera_set_view_pos(cameraZoomedOut,camera_get_view_x(cameraZoomedOut)+objRocket2.hspeed,0);
		}
		if(objRocket2.x < zoomedOutCenteredX - 450 && objRocket2.hspeed<0){
			//move the camera according to the player's horizontal speed
			camera_set_view_pos(cameraZoomedOut,camera_get_view_x(cameraZoomedOut)+objRocket2.hspeed,0);
		}
	}
}else{
	//if not, set it the view port accordingly
	view_camera[0] = cameraZoomedIn;
}

//update the zoomed out camera's center x
zoomedOutCenteredX = camera_get_view_x(cameraZoomedOut) + zoomedOutWidth/2;

//make sure the zoomed in camera is always following the player
camera_set_view_pos(cameraZoomedIn,objRocket2.x-zoomedInWidth/2,objRocket2.y-zoomedInHeight/2);