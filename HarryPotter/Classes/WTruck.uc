//===============================================================================
//  [Truck] 
//===============================================================================

class WTruck extends Weapon;
//#EXEC MESH  MODELIMPORT MESH=TruckMesh MODELFILE=models\Truck.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=TruckMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=TruckAnims ANIMFILE=models\Truck.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=TruckMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=TruckMesh ANIM=TruckAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=TruckAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=TruckTex0  FILE=TEXTURES\ambulanc_128.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=TruckMesh NUM=0 TEXTURE=TruckTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: ambulanc_128.bmp  Path: H:\Art\Models\Objects\Dursley Props\Toys\Truck 




function float RateSelf( out int bUseAltMode )
{
	return -20;
}

defaultproperties
{
     ThirdPersonMesh=SkeletalMesh'HarryPotter.TruckMesh'
     Mesh=SkeletalMesh'HarryPotter.TruckMesh'
}
