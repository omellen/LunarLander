//set the width and height of the zoomed in and zoomed out cameras
zoomedOutWidth = 1300;
ZoomedOutHeight = room_height;
zoomedInWidth = 683;
zoomedInHeight = 384;

//create the cameras and pass them into variables
cameraZoomedOut = camera_create_view(1300,0,zoomedOutWidth,ZoomedOutHeight);
cameraZoomedIn = camera_create_view(objRocket2.x-zoomedInWidth/2,objRocket2.y-zoomedInHeight/2,zoomedInWidth,zoomedInHeight);

//create a variable that determines whether the camera is zoomed in or out
//0 for out, 1 for in
zoomedIn = 0;

//create a variable for the x value of the zoomed out camera
zoomedOutCenteredX = camera_get_view_x(cameraZoomedOut) + zoomedOutWidth/2;

//set the viewport to the camera
view_camera[0] = cameraZoomedOut;
