//===============================================================================
//  [DragonStatue] 
//===============================================================================

class DragonStatue extends HProps;
#exec MESH  MODELIMPORT MESH=DragonStatueMesh MODELFILE=models\DragonStatueMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=DragonStatueMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=DragonStatueAnims ANIMFILE=models\DragonStatueAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=DragonStatueMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=DragonStatueMesh ANIM=DragonStatueAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=DragonStatueAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=DragonStatueTex0  FILE=TEXTURES\DragonStatueTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=DragonStatueMesh NUM=0 TEXTURE=DragonStatueTex0

// Original material [0] is [Material #14] SkinIndex: 0 Bitmap: dragonsc_256.bmp  Path: D:\Harry Potter\Art\Objects\Dragon Sculpture

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.DragonStatueMesh'
}
