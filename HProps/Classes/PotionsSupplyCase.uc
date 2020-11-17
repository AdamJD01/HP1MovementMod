//===============================================================================
//  [PotionsSupplyCase] 
//===============================================================================

class PotionsSupplyCase extends HProps;
#exec MESH  MODELIMPORT MESH=PotionsSupplyCaseMesh MODELFILE=models\PotionsSupplyCaseMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionsSupplyCaseMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionsSupplyCaseAnims ANIMFILE=models\PotionsSupplyCaseAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionsSupplyCaseMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionsSupplyCaseMesh ANIM=PotionsSupplyCaseAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionsSupplyCaseAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionsSupplyCaseTex0  FILE=TEXTURES\PotionsSupplyCaseTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionsSupplyCaseMesh NUM=0 TEXTURE=PotionsSupplyCaseTex0

// Original material [0] is [Material #3] SkinIndex: 0 Bitmap: suplcase_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Potions Class

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionsSupplyCaseMesh'
}
