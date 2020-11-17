//===============================================================================
// 
//===============================================================================

class gen_male_0 extends basechar;


function respondToStation()
{

	if(destP.aiData[stationNumber].behavior==BH_die)
	{
	
		destroy();
	}

}

defaultproperties
{
     walkAnimName=run
     idleAnimName=fidget_1
     GroundSpeed=150
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skgen_male_1Mesh'
     AmbientGlow=75
     MultiSkins(0)=Texture'HPModels.Skins.skgen_male_0Tex0'
     MultiSkins(1)=Texture'HPModels.Skins.skgen_male_0Tex1'
     CollisionHeight=42
}
