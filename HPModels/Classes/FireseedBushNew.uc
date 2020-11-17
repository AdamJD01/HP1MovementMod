//===============================================================================
//  [FireseedBushNew] 
//===============================================================================

class FireseedBushNew extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=FireseedBushNewMesh MODELFILE=models\FireseedBushNewMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FireseedBushNewMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FireseedBushNewAnims ANIMFILE=models\FireseedBushNewAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FireseedBushNewMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FireseedBushNewMesh ANIM=FireseedBushNewAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FireseedBushNewAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FireseedBushNewTex0  FILE=TEXTURES\FireseedBushNewTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FireseedBushNewMesh NUM=0 TEXTURE=FireseedBushNewTex0

// Original material [0] is [FIRESEED_SKIN00] SkinIndex: 0 Bitmap: FIRESEED.bmp  Path: D:\Harry Potter\Art\Characters\FireSeed Plant

defaultproperties
{
}
