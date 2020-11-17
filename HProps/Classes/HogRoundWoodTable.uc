//===============================================================================
//  [HogRoundWoodTable] 
//===============================================================================

class HogRoundWoodTable extends HProps;
#exec MESH  MODELIMPORT MESH=HogRoundWoodTableMesh MODELFILE=models\HogRoundWoodTableMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogRoundWoodTableMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogRoundWoodTableAnims ANIMFILE=models\HogRoundWoodTableAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogRoundWoodTableMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogRoundWoodTableMesh ANIM=HogRoundWoodTableAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogRoundWoodTableAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogRoundWoodTableTex0  FILE=TEXTURES\HogRoundWoodTableTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogRoundWoodTableMesh NUM=0 TEXTURE=HogRoundWoodTableTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: hogroundtable_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogRoundWoodTableMesh'
}
