//===============================================================================
//  [PotionsBookPedestal] 
//===============================================================================

class PotionsBookPedestal extends HProps;
#exec MESH  MODELIMPORT MESH=PotionsBookPedestalMesh MODELFILE=models\PotionsBookPedestalMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionsBookPedestalMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionsBookPedestalAnims ANIMFILE=models\PotionsBookPedestalAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionsBookPedestalMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionsBookPedestalMesh ANIM=PotionsBookPedestalAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionsBookPedestalAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionsBookPedestalTex0  FILE=TEXTURES\PotionsBookPedestalTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionsBookPedestalMesh NUM=0 TEXTURE=PotionsBookPedestalTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: bkpedstl_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Potions Class

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionsBookPedestalMesh'
}
