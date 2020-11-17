//===============================================================================
//  [FirePlaceWood] 
//===============================================================================

class FirePlaceWood extends HProps;
#exec MESH  MODELIMPORT MESH=FirePlaceWoodMesh MODELFILE=models\FirePlaceWoodMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FirePlaceWoodMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FirePlaceWoodAnims ANIMFILE=models\FirePlaceWoodAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FirePlaceWoodMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FirePlaceWoodMesh ANIM=FirePlaceWoodAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FirePlaceWoodAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FirePlaceWoodTex0  FILE=TEXTURES\FirePlaceWoodTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FirePlaceWoodMesh NUM=0 TEXTURE=FirePlaceWoodTex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: firewood_128.bmp  Path: H:\Art\Models\Objects\Working\Lorian\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FirePlaceWoodMesh'
}
