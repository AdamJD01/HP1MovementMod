//===============================================================================
//  [RememberallChaseArrow] 
//===============================================================================

class RememberallChaseArrow extends HProps;
#exec MESH  MODELIMPORT MESH=RememberallChaseArrowMesh MODELFILE=models\RememberallChaseArrowMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=RememberallChaseArrowMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=RememberallChaseArrowAnims ANIMFILE=models\RememberallChaseArrowAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=RememberallChaseArrowMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=RememberallChaseArrowMesh ANIM=RememberallChaseArrowAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=RememberallChaseArrowAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=RememberallChaseArrowTex0  FILE=TEXTURES\RememberallChaseArrowTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=RememberallChaseArrowMesh NUM=0 TEXTURE=RememberallChaseArrowTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: chasesgn_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\rememberall

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.RememberallChaseArrowMesh'
}
