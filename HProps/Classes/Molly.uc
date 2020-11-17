//===============================================================================
//  [Molly] 
//===============================================================================

class Molly extends HProps;
#exec MESH  MODELIMPORT MESH=MollyMesh MODELFILE=models\MollyMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=MollyMesh X=0 Y=0 Z=32 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=MollyAnims ANIMFILE=models\MollyAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=MollyMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=MollyMesh ANIM=MollyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=MollyAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=MollyTex0  FILE=TEXTURES\MollyTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=MollyMesh NUM=0 TEXTURE=MollyTex0

// Original material [0] is [skin00.MASKED] SkinIndex: 0 Bitmap: Molly.bmp  Path: C:\HP\HProps\Textures

function touch (actor other)
{
	if(other==playerharry)
	{
		gotostate('killmolly');

	}

}

state killmolly
{
	begin:
		PlaySound(sound'HPSounds.hub3_sfx.troll_booger_squish');
		playerharry.bHasMoly = true;
		
		destroy();
	loop:
		sleep(1);
		goto 'loop';
}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.MollyMesh'
}
