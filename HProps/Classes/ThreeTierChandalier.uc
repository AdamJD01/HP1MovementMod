//===============================================================================
//  [ThreeTierChandalier] 
//===============================================================================

class ThreeTierChandalier extends HProps;
#exec MESH  MODELIMPORT MESH=ThreeTierChandalierMesh MODELFILE=models\ThreeTierChandalierMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ThreeTierChandalierMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ThreeTierChandalierAnims ANIMFILE=models\ThreeTierChandalierAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ThreeTierChandalierMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ThreeTierChandalierMesh ANIM=ThreeTierChandalierAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ThreeTierChandalierAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ThreeTierChandalierTex0  FILE=TEXTURES\ThreeTierChandalierTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ThreeTierChandalierMesh NUM=0 TEXTURE=ThreeTierChandalierTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: Chndaler_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ThreeTierChandalierMesh'
}
