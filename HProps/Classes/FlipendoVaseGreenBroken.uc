//===============================================================================
//  [FlipendoVaseGreenBroken] 
//===============================================================================

class FlipendoVaseGreenBroken extends HProps;
#exec MESH  MODELIMPORT MESH=FlipendoVaseGreenBrokenMesh MODELFILE=models\FlipendoVaseGreenBrokenMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FlipendoVaseGreenBrokenMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FlipendoVaseGreenBrokenAnims ANIMFILE=models\FlipendoVaseGreenBrokenAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FlipendoVaseGreenBrokenMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FlipendoVaseGreenBrokenMesh ANIM=FlipendoVaseGreenBrokenAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FlipendoVaseGreenBrokenAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FlipendoVaseGreenBrokenTex0  FILE=TEXTURES\FlipendoVaseGreenBrokenTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FlipendoVaseGreenBrokenMesh NUM=0 TEXTURE=FlipendoVaseGreenBrokenTex0

// Original material [0] is [Material #9] SkinIndex: 0 Bitmap: fvgrnbrk_128.bmp  Path: D:\Harry Potter\Art\Objects\Flipendo\Flipendo Vases

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FlipendoVaseGreenBrokenMesh'
}
