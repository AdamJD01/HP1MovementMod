//===============================================================================
//  [FlipendoArrow] 
//===============================================================================

class FlipendoArrow extends HProps;
#exec MESH  MODELIMPORT MESH=FlipendoArrowMesh MODELFILE=models\FlipendoArrowMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FlipendoArrowMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FlipendoArrowAnims ANIMFILE=models\FlipendoArrowAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FlipendoArrowMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FlipendoArrowMesh ANIM=FlipendoArrowAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FlipendoArrowAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FlipendoArrowTex0  FILE=TEXTURES\FlipendoArrowTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FlipendoArrowMesh NUM=0 TEXTURE=FlipendoArrowTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: fliparow_128.bmp  Path: D:\Harry Potter\Art\Objects\Flipendo\arrow

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FlipendoArrowMesh'
}
