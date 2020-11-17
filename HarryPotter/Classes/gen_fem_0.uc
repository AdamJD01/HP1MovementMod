//===============================================================================
// 
//===============================================================================

class gen_fem_0 extends basechar;


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
     GroundSpeed=200
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skgen_fem_1Mesh'
     AmbientGlow=75
     MultiSkins(0)=Texture'HPModels.Skins.skgen_fem_0Tex0'
     MultiSkins(1)=Texture'HPModels.Skins.skgen_fem_0Tex1'
     CollisionHeight=42
}
