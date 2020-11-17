//===============================================================================
//  [HunchbackWitch] 
//===============================================================================

class HunchbackWitch extends HProps;
#exec MESH  MODELIMPORT MESH=HunchbackWitchMesh MODELFILE=models\HunchbackWitchMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HunchbackWitchMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HunchbackWitchAnims ANIMFILE=models\HunchbackWitchAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HunchbackWitchMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HunchbackWitchMesh ANIM=HunchbackWitchAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HunchbackWitchAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HunchbackWitchTex0  FILE=TEXTURES\HunchbackWitchTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=HunchbackWitchTex1  FILE=TEXTURES\HunchbackWitchTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HunchbackWitchMesh NUM=0 TEXTURE=HunchbackWitchTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=HunchbackWitchMesh NUM=1 TEXTURE=HunchbackWitchTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: Witch1.bmp  Path: D:\Harry Potter\Art\Objects\Hunchback Witch 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: hatrimtwosided.bmp  Path: D:\Harry Potter\Art\Objects\Hunchback Witch

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HunchbackWitchMesh'
}
