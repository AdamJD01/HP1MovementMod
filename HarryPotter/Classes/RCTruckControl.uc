//===============================================================================
//  [RCTruckControl] 
//===============================================================================

class RCTruckControl extends Weapon;
//#EXEC MESH  MODELIMPORT MESH=RCTruckControlMesh MODELFILE=models\RCTruckControl.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=RCTruckControlMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=RCTruckControlAnims ANIMFILE=models\RCTruckControl.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=RCTruckControlMesh X=0.5 Y=0.5 Z=0.5
//#EXEC MESH  DEFAULTANIM MESH=RCTruckControlMesh ANIM=RCTruckControlAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=RCTruckControlAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=RCTruckControlTex0  FILE=TEXTURES\rccontol_64.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=RCTruckControlMesh NUM=0 TEXTURE=RCTruckControlTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: rccontol_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\privet 



function float RateSelf( out int bUseAltMode )
{
	return 10;
}

defaultproperties
{
     ThirdPersonMesh=SkeletalMesh'HarryPotter.RCTruckControlMesh'
     Mesh=SkeletalMesh'HarryPotter.RCTruckControlMesh'
     DrawScale=0.4
}
