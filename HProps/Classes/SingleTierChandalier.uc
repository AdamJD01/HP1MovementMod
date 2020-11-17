//===============================================================================
//  [SingleTierChandalier] 
//===============================================================================

class SingleTierChandalier extends HProps;
#exec MESH  MODELIMPORT MESH=SingleTierChandalierMesh MODELFILE=models\SingleTierChandalierMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SingleTierChandalierMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SingleTierChandalierAnims ANIMFILE=models\SingleTierChandalierAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SingleTierChandalierMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=SingleTierChandalierMesh ANIM=SingleTierChandalierAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SingleTierChandalierAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=SingleTierChandalierTex0  FILE=TEXTURES\SingleTierChandalierTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=SingleTierChandalierMesh NUM=0 TEXTURE=SingleTierChandalierTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: Chndaler_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.SingleTierChandalierMesh'
}
