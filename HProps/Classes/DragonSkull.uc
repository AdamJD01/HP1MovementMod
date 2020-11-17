//===============================================================================
//  [DragonSkull] 
//===============================================================================

class DragonSkull extends HProps;
#exec MESH  MODELIMPORT MESH=DragonSkullMesh MODELFILE=models\DragonSkullMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=DragonSkullMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=DragonSkullAnims ANIMFILE=models\DragonSkullAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=DragonSkullMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=DragonSkullMesh ANIM=DragonSkullAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=DragonSkullAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=DragonSkullTex0  FILE=TEXTURES\DragonSkullTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=DragonSkullMesh NUM=0 TEXTURE=DragonSkullTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: drgskull_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.DragonSkullMesh'
}
