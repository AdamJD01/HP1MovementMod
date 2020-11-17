//===============================================================================
//  [FlipendoVaseMingBroken] 
//===============================================================================

class FlipendoVaseMingBroken extends HProps;
#exec MESH  MODELIMPORT MESH=FlipendoVaseMingBrokenMesh MODELFILE=models\FlipendoVaseMingBrokenMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FlipendoVaseMingBrokenMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FlipendoVaseMingBrokenAnims ANIMFILE=models\FlipendoVaseMingBrokenAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FlipendoVaseMingBrokenMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FlipendoVaseMingBrokenMesh ANIM=FlipendoVaseMingBrokenAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FlipendoVaseMingBrokenAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FlipendoVaseMingBrokenTex0  FILE=TEXTURES\FlipendoVaseMingBrokenTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FlipendoVaseMingBrokenMesh NUM=0 TEXTURE=FlipendoVaseMingBrokenTex0

// Original material [0] is [mingvasebroken] SkinIndex: 0 Bitmap: fvmingbk_256.bmp  Path: D:\Harry Potter\Art\Objects\Flipendo\Flipendo Vases

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FlipendoVaseMingBrokenMesh'
}
