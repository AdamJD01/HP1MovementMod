//===============================================================================
//  [PotionsIngredientJar1] 
//===============================================================================

class PotionsIngredientJar1 extends HProps;
#exec MESH  MODELIMPORT MESH=PotionsIngredientJar1Mesh MODELFILE=models\PotionsIngredientJar1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionsIngredientJar1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionsIngredientJar1Anims ANIMFILE=models\PotionsIngredientJar1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionsIngredientJar1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionsIngredientJar1Mesh ANIM=PotionsIngredientJar1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionsIngredientJar1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionsIngredientJar1Tex0  FILE=TEXTURES\PotionsIngredientJar1Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionsIngredientJar1Mesh NUM=0 TEXTURE=PotionsIngredientJar1Tex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: ptionjr1_128.bmp  Path: D:\Harry Potter\Art\Objects\Potions Class\Ingredient jars

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionsIngredientJar1Mesh'
}
