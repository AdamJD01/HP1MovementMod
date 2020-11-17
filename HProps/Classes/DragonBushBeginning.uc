//===============================================================================
//  [DragonBushBeginning] 
//===============================================================================

class DragonBushBeginning extends HProps;
#exec MESH  MODELIMPORT MESH=DragonBushBeginningMesh MODELFILE=models\DragonBushBeginningMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=DragonBushBeginningMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=DragonBushBeginningAnims ANIMFILE=models\DragonBushBeginningAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=DragonBushBeginningMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=DragonBushBeginningMesh ANIM=DragonBushBeginningAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=DragonBushBeginningAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=DragonBushBeginningTex0  FILE=TEXTURES\DragonBushBeginningTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=DragonBushBeginningMesh NUM=0 TEXTURE=DragonBushBeginningTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: dragonbush2.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures\Dragon Sculpture

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.DragonBushBeginningMesh'
}
