//===============================================================================
//  [FlobberwormMucus] 
//===============================================================================

class FlobberwormMucus extends HProps;
#exec MESH  MODELIMPORT MESH=FlobberwormMucusMesh MODELFILE=models\FlobberwormMucusMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FlobberwormMucusMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FlobberwormMucusAnims ANIMFILE=models\FlobberwormMucusAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FlobberwormMucusMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FlobberwormMucusMesh ANIM=FlobberwormMucusAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FlobberwormMucusAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FlobberwormMucusTex0  FILE=TEXTURES\FlobberwormMucusTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FlobberwormMucusMesh NUM=0 TEXTURE=FlobberwormMucusTex0

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: FlobberwormMucus.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 

function touch (actor other)
{
	if(other==playerharry)
	{
		gotostate('killflobberwormmucus');

	}

}

state killflobberwormmucus
{
	begin:
		playerharry.bHasMucus = true;
		PlaySound(sound'HPSounds.hub3_sfx.troll_booger_squish');
		
		destroy();
	loop:
		sleep(1);
		goto 'loop';
}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FlobberwormMucusMesh'
}
