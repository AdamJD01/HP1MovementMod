//===============================================================================
//  [FlipendoVaseGreenShard] 
//===============================================================================

class FlipendoVaseGreenShard extends HProps;
#exec MESH  MODELIMPORT MESH=FlipendoVaseGreenShardMesh MODELFILE=models\FlipendoVaseGreenShardMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FlipendoVaseGreenShardMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FlipendoVaseGreenShardAnims ANIMFILE=models\FlipendoVaseGreenShardAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FlipendoVaseGreenShardMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FlipendoVaseGreenShardMesh ANIM=FlipendoVaseGreenShardAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FlipendoVaseGreenShardAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FlipendoVaseGreenShardTex0  FILE=TEXTURES\FlipendoVaseGreenShardTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FlipendoVaseGreenShardMesh NUM=0 TEXTURE=FlipendoVaseGreenShardTex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: fvgrnbrk_128.bmp  Path: D:\Harry Potter\Art\Objects\Flipendo\Flipendo Vases

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FlipendoVaseGreenShardMesh'
}
