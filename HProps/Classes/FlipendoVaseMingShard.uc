//===============================================================================
//  [FlipendoVaseMingShard] 
//===============================================================================

class FlipendoVaseMingShard extends HProps;
#exec MESH  MODELIMPORT MESH=FlipendoVaseMingShardMesh MODELFILE=models\FlipendoVaseMingShardMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FlipendoVaseMingShardMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FlipendoVaseMingShardAnims ANIMFILE=models\FlipendoVaseMingShardAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FlipendoVaseMingShardMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FlipendoVaseMingShardMesh ANIM=FlipendoVaseMingShardAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FlipendoVaseMingShardAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FlipendoVaseMingShardTex0  FILE=TEXTURES\FlipendoVaseMingShardTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FlipendoVaseMingShardMesh NUM=0 TEXTURE=FlipendoVaseMingShardTex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: fvmingbk_256.bmp  Path: D:\Harry Potter\Art\Objects\Flipendo\Flipendo Vases

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FlipendoVaseMingShardMesh'
}
