//===============================================================================
//  [GreenPotionBottle] 
//===============================================================================

class GreenPotionBottle extends HProps;
#exec MESH  MODELIMPORT MESH=GreenPotionBottleMesh MODELFILE=models\GreenPotionBottleMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenPotionBottleMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenPotionBottleAnims ANIMFILE=models\GreenPotionBottleAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenPotionBottleMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenPotionBottleMesh ANIM=GreenPotionBottleAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenPotionBottleAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenPotionBottleTex0  FILE=TEXTURES\GreenPotionBottleTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenPotionBottleMesh NUM=0 TEXTURE=GreenPotionBottleTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: greenbot_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects\bottles 

function touch (actor other)
{
	if(other==playerharry)
	{
//		hpHud(playerharry.myhud).numFrogs=hphud(playerharry.myhud).numFrogs+1;
		PlaySound(sound'HPSounds.magic_sfx.pickup_life_potion');
//		PlaySound(sound'HPSounds.dlg_har.Har_004');

		playerharry.AddHealth(10);
		destroy();
	}


}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenPotionBottleMesh'
}
