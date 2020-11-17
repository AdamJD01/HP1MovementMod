//===============================================================================
//  [TwoTierChandalier] 
//===============================================================================

class TwoTierChandalier extends HProps;
#exec MESH  MODELIMPORT MESH=TwoTierChandalierMesh MODELFILE=models\TwoTierChandalierMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TwoTierChandalierMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TwoTierChandalierAnims ANIMFILE=models\TwoTierChandalierAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TwoTierChandalierMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TwoTierChandalierMesh ANIM=TwoTierChandalierAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TwoTierChandalierAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TwoTierChandalierTex0  FILE=TEXTURES\TwoTierChandalierTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TwoTierChandalierMesh NUM=0 TEXTURE=TwoTierChandalierTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: Chndaler_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TwoTierChandalierMesh'
}
