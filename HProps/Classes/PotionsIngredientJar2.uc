//===============================================================================
//  [PotionsIngredientJar2] 
//===============================================================================

class PotionsIngredientJar2 extends HProps;
#exec MESH  MODELIMPORT MESH=PotionsIngredientJar2Mesh MODELFILE=models\PotionsIngredientJar2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionsIngredientJar2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionsIngredientJar2Anims ANIMFILE=models\PotionsIngredientJar2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionsIngredientJar2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionsIngredientJar2Mesh ANIM=PotionsIngredientJar2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionsIngredientJar2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionsIngredientJar2Tex0  FILE=TEXTURES\PotionsIngredientJar2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionsIngredientJar2Mesh NUM=0 TEXTURE=PotionsIngredientJar2Tex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: ptionjr2_128.bmp  Path: D:\Harry Potter\Art\Objects\Potions Class\Ingredient jars

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionsIngredientJar2Mesh'
}
