//===============================================================================
//  [DragonBush] 
//===============================================================================

class DragonBush extends HProps;
#exec MESH  MODELIMPORT MESH=DragonBushMesh MODELFILE=models\DragonBushMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=DragonBushMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=DragonBushAnims ANIMFILE=models\DragonBushAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=DragonBushMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=DragonBushMesh ANIM=DragonBushAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=DragonBushAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=DragonBushTex0  FILE=TEXTURES\DragonBushTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=DragonBushMesh NUM=0 TEXTURE=DragonBushTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: DragonBush.bmp  Path: C:\HP\HProps\Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.DragonBushMesh'
}
