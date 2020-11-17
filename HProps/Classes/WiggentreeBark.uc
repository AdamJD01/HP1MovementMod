//===============================================================================
//  [WiggentreeBark] 
//===============================================================================

class WiggentreeBark extends HProps;
#exec MESH  MODELIMPORT MESH=WiggentreeBarkMesh MODELFILE=models\WiggentreeBarkMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=WiggentreeBarkMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=WiggentreeBarkAnims ANIMFILE=models\WiggentreeBarkAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=WiggentreeBarkMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=WiggentreeBarkMesh ANIM=WiggentreeBarkAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=WiggentreeBarkAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=WiggentreeBarkTex0  FILE=TEXTURES\WiggentreeBarkTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=WiggentreeBarkMesh NUM=0 TEXTURE=WiggentreeBarkTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: WiggentreeBark.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 

function touch (actor other)
{
	if(other==playerharry)
	{
		gotostate('killwiggentreebark');

	}

}

state killwiggentreebark
{
	begin:
		PlaySound(sound'HPSounds.hub3_sfx.troll_booger_squish');
		playerharry.bHasBark= true;
		
		destroy();
	loop:
		sleep(1);
		goto 'loop';
}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.WiggentreeBarkMesh'
}
