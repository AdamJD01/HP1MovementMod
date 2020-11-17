//===============================================================================
//  [PotionsIngredientJar4] 
//===============================================================================

class PotionsIngredientJar4 extends HProps;
#exec MESH  MODELIMPORT MESH=PotionsIngredientJar4Mesh MODELFILE=models\PotionsIngredientJar4Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionsIngredientJar4Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionsIngredientJar4Anims ANIMFILE=models\PotionsIngredientJar4Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionsIngredientJar4Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionsIngredientJar4Mesh ANIM=PotionsIngredientJar4Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionsIngredientJar4Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionsIngredientJar4Tex0  FILE=TEXTURES\PotionsIngredientJar4Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionsIngredientJar4Mesh NUM=0 TEXTURE=PotionsIngredientJar4Tex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: ptionbot_128.bmp  Path: D:\Harry Potter\Art\Objects\Potions Class\Ingredient jars

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionsIngredientJar4Mesh'
}
