//===============================================================================
//  [PotionsIngredientJar3] 
//===============================================================================

class PotionsIngredientJar3 extends HProps;
#exec MESH  MODELIMPORT MESH=PotionsIngredientJar3Mesh MODELFILE=models\PotionsIngredientJar3Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionsIngredientJar3Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionsIngredientJar3Anims ANIMFILE=models\PotionsIngredientJar3Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionsIngredientJar3Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionsIngredientJar3Mesh ANIM=PotionsIngredientJar3Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionsIngredientJar3Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionsIngredientJar3Tex0  FILE=TEXTURES\PotionsIngredientJar3Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionsIngredientJar3Mesh NUM=0 TEXTURE=PotionsIngredientJar3Tex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: ptionjr3_128.bmp  Path: D:\Harry Potter\Art\Objects\Potions Class\Ingredient jars

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionsIngredientJar3Mesh'
}
