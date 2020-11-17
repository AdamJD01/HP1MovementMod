//===============================================================================
//  [RectangleWoodTable] 
//===============================================================================

class RectangleWoodTable extends HProps;
#exec MESH  MODELIMPORT MESH=RectangleWoodTableMesh MODELFILE=models\RectangleWoodTableMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=RectangleWoodTableMesh X=0 Y=0 Z=30 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=RectangleWoodTableAnims ANIMFILE=models\RectangleWoodTableAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=RectangleWoodTableMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=RectangleWoodTableMesh ANIM=RectangleWoodTableAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=RectangleWoodTableAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=RectangleWoodTableTex0  FILE=TEXTURES\RectangleWoodTableTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=RectangleWoodTableMesh NUM=0 TEXTURE=RectangleWoodTableTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: hogrectb_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.RectangleWoodTableMesh'
}
