//===============================================================================
//  [GHallDumbleThrone] 
//===============================================================================

class GHallDumbleThrone extends HProps;
#exec MESH  MODELIMPORT MESH=GHallDumbleThroneMesh MODELFILE=models\GHallDumbleThroneMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GHallDumbleThroneMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GHallDumbleThroneAnims ANIMFILE=models\GHallDumbleThroneAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GHallDumbleThroneMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GHallDumbleThroneMesh ANIM=GHallDumbleThroneAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GHallDumbleThroneAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GHallDumbleThroneTex0  FILE=TEXTURES\GHallDumbleThroneTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GHallDumbleThroneMesh NUM=0 TEXTURE=GHallDumbleThroneTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: ghthrone_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Great Hall

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GHallDumbleThroneMesh'
}
