//===============================================================================
//  [GreenhouseCactus] 
//===============================================================================

class GreenhouseCactus extends HProps;
#exec MESH  MODELIMPORT MESH=GreenhouseCactusMesh MODELFILE=models\GreenhouseCactusMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenhouseCactusMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenhouseCactusAnims ANIMFILE=models\GreenhouseCactusAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenhouseCactusMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenhouseCactusMesh ANIM=GreenhouseCactusAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenhouseCactusAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenhouseCactusTex0  FILE=TEXTURES\GreenhouseCactusTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenhouseCactusMesh NUM=0 TEXTURE=GreenhouseCactusTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: Cactus.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenhouseCactusMesh'
}
