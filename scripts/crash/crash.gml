function crash(myX, myY){
	for(var i =0; i < 30; i++){
		var spark = instance_create_layer(myX, myY, "Instances", objSpark);
		spark.direction = irandom_range(0,360);
		if(i%5==0){
			instance_create_layer(myX, myY, "Instances", objShipParts);
		}
	}
}