//set x position to just off of the rocket's x position
x = objRocket2.x  + irandom_range(-2,2);

//each spark recieves a slightly varied speed and direction
speed = irandom_range(1,3);
direction = objRocket2.image_angle-90 + irandom_range(-20,20);

//set "physics" variables accordingly
gravity = 0.001;
friction = 0.0002;

//set lifespand so that the spark will fade out
myLifespan = 120;
currentLife = myLifespan;

//pick a color for the spark (red, yellow, or orange)
image_index = irandom_range(1,3);



