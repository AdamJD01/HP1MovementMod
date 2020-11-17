//===============================================================================
//  [HogSquareWoodTable] 
//===============================================================================

class HogSquareWoodTable extends HProps;
#exec MESH  MODELIMPORT MESH=HogSquareWoodTableMesh MODELFILE=models\HogSquareWoodTableMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogSquareWoodTableMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogSquareWoodTableAnims ANIMFILE=models\HogSquareWoodTableAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogSquareWoodTableMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogSquareWoodTableMesh ANIM=HogSquareWoodTableAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogSquareWoodTableAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogSquareWoodTableTex0  FILE=TEXTURES\HogSquareWoodTableTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogSquareWoodTableMesh NUM=0 TEXTURE=HogSquareWoodTableTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: hogsquaretable_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogSquareWoodTableMesh'
}
