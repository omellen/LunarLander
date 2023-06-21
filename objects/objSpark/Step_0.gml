//aging
currentLife--;
//dissappearing gradually
image_alpha=currentLife/myLifespan;
//am I ready to die
if(currentLife==0){
	instance_destroy();
}




