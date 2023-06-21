function perlinNoise(nx, ny, nbOctave){
	
	/////////////////////
	/*
	
	LeMasters, G 2020, 2022
	(cobbled together from various sources)
	Is some of this code yours?  Email me!
	garrison@colophon.org
	
	relatively harmless
	somewhat accurate perlin noise generation
	
	nx, ny --> points within "cloud"
	nbOctave --> how many octaves
	(each octave multiplies complexity of outcome)
	
	NB:
	- output range between 0 and 1
	- maximum octave = 7
	
	*/
	/////////////////////
	
	var result = 0;
	var sx = floor(nx * 256);
	var sy = floor(ny * 256);
	var octave = nbOctave;
	
	// loop descends octaves until reaching 0

	while(octave != 0){
		var bX = sx & $FF;
		var bY = sy & $FF;
		var sxp = sx >> 8;
		var syp = sy >> 8;

		//corner noise
		
		var Y1376312589_00=syp*1376312589;
		var Y1376312589_01=Y1376312589_00+1376312589;
		var XY1376312589_00=sxp+Y1376312589_00;
		var XY1376312589_10=XY1376312589_00+1;
		var XY1376312589_01=sxp+Y1376312589_01;
		var XY1376312589_11=XY1376312589_01+1;
		var XYBASE_00=(XY1376312589_00<<13)^XY1376312589_00;
		var XYBASE_10=(XY1376312589_10<<13)^XY1376312589_10;
		var XYBASE_01=(XY1376312589_01<<13)^XY1376312589_01;
		var XYBASE_11=(XY1376312589_11<<13)^XY1376312589_11;
		
		// pseudo random values
		
		var alt1=(XYBASE_00 * (XYBASE_00 * XYBASE_00 * 15731 + 789221) + 1376312589) ;
		var alt2=(XYBASE_10 * (XYBASE_10 * XYBASE_10 * 15731 + 789221) + 1376312589) ;
		var alt3=(XYBASE_01 * (XYBASE_01 * XYBASE_01 * 15731 + 789221) + 1376312589) ;
		var alt4=(XYBASE_11 * (XYBASE_11 * XYBASE_11 * 15731 + 789221) + 1376312589) ;

		// gradient noise = extra time consuming but better outcomes
		// bit shift our pseudorandoms
		
		var grad1X=(alt1 & $FF)-128;
		var grad1Y=((alt1 >> 8) & $FF)-128;
		var grad2X=(alt2 & $FF)-128;
		var grad2Y=((alt2 >> 8) & $FF)-128;
		var grad3X=(alt3 & $FF)-128;
		var grad3Y=((alt3 >> 8) & $FF)-128;
		var grad4X=(alt4 & $FF)-128;
		var grad4Y=((alt4 >> 8) & $FF)-128;

		var sX1=bX>>1;
		var sY1=bY>>1;
		var sX2=128-sX1;
		var sY2 = sY1;
		var sX3 = sX1;
		var sY3=128-sY1;
		var sX4=128-sX1;
		var sY4=128-sY1;

		alt1=(grad1X*sX1+grad1Y*sY1)+16384+((alt1 & $FF0000)>>9);
		alt2=(grad2X*sX2+grad2Y*sY2)+16384+((alt2 & $FF0000)>>9);
		alt3=(grad3X*sX3+grad3Y*sY3)+16384+((alt3 & $FF0000)>>9);
		alt4=(grad4X*sX4+grad4Y*sY4)+16384+((alt4 & $FF0000)>>9);

		// use bicubic interpolation of values
		// again, time consuming but smoother than linear interpolation
		
		var bX2=(bX*bX)>>8;
		var bX3=(bX2*bX)>>8;
		var _3bX2=3*bX2;
		var _2bX3=2*bX3;
		var alt12= alt1 - (((_3bX2 - _2bX3) * (alt1-alt2)) >> 8);
		var alt34= alt3 - (((_3bX2 - _2bX3) * (alt3-alt4)) >> 8);

		var bY2=(bY*bY)>>8;
		var bY3=(bY2*bY)>>8;
		var _3bY2=3*bY2;
		var _2bY3=2*bY3;
		var val = alt12 - (((_3bY2 - _2bY3) * (alt12-alt34)) >> 8);

		val = val * 256;

		//put them together with bitshifts according to octave
		
		result = result + (val<<octave);
		
		// go down an octave
		octave--;
		
		// bitshift the next values
		sx = sx << 1;
		sy = sy << 1;
	}
	
	// we're out of octaves:  Take us home!
	
	result = result >> (16+nbOctave+1);
	
	// scale it down again:  0 to 1
	// change this if you want to easily adjust the return range
	// at this point, result will be between 0 and 255
	
	result = (result + 1) / 256;
	
	return result;
}