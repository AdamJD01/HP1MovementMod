	class george extends baseChar;



	var int dialog1[20];
	var int currentspeech;
	var baseprops desk;
	var vector newloc;
	var rotator pigrot;



function respondtoStation()
{
	if(destP.aiData[stationNumber].behavior==BH_die)
	{
	
		destroy();
	}



	if(destP.aiData[stationNumber].behavior==BH_idle1)
	{
		loopanim('breathe');
	}

}

defaultproperties
{
     GroundSpeed=100
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skgeorgeMesh'
}
