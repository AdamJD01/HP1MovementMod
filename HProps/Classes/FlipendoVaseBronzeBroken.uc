//===============================================================================
//  [FlipendoVaseBronzeBroken] 
//===============================================================================

class FlipendoVaseBronzeBroken extends HProps;
#exec MESH  MODELIMPORT MESH=FlipendoVaseBronzeBrokenMesh MODELFILE=models\FlipendoVaseBronzeBrokenMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FlipendoVaseBronzeBrokenMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FlipendoVaseBronzeBrokenAnims ANIMFILE=models\FlipendoVaseBronzeBrokenAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FlipendoVaseBronzeBrokenMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FlipendoVaseBronzeBrokenMesh ANIM=FlipendoVaseBronzeBrokenAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FlipendoVaseBronzeBrokenAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FlipendoVaseBronzeBrokenTex0  FILE=TEXTURES\FlipendoVaseBronzeBrokenTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FlipendoVaseBronzeBrokenMesh NUM=0 TEXTURE=FlipendoVaseBronzeBrokenTex0

// Original material [0] is [Material #9] SkinIndex: 0 Bitmap: fvbrzbrk_64.bmp  Path: D:\Harry Potter\Art\Objects\Flipendo Vases

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FlipendoVaseBronzeBrokenMesh'
}
