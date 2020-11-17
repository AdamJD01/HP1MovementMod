//===============================================================================
//  [Dittany] 
//===============================================================================

class Dittany extends HProps;
#exec MESH  MODELIMPORT MESH=DittanyMesh MODELFILE=models\DittanyMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=DittanyMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=DittanyAnims ANIMFILE=models\DittanyAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=DittanyMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=DittanyMesh ANIM=DittanyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=DittanyAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=DittanyTex0  FILE=TEXTURES\DittanyTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=DittanyMesh NUM=0 TEXTURE=DittanyTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: Dittany.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 

function touch (actor other)
{
	if(other==playerharry)
	{
		gotostate('killdittany');

	}

}

state killdittany
{
	begin:
		PlaySound(sound'HPSounds.hub3_sfx.troll_booger_squish');
		playerharry.bHasDittany = true;
		
		destroy();
	loop:
		sleep(1);
		goto 'loop';
}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.DittanyMesh'
}
