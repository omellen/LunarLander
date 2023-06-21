//pick a random "part" of the ship
image_index = irandom_range(0,5);

//each ship part recieves a slightly varied speed and direction
speed = irandom_range(2,4);
direction = irandom_range(0,360);

//set "physics" variables accordingly
gravity = 0.01;
friction = 0.0002;

//set lifespand so that the spark will fade out
myLifespan = 180;
currentLife = myLifespan;
rotationAmount = 3;