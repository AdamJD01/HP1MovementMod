//===============================================================================
//  [BushSprite11] 
//===============================================================================

class BushSprite11 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite11Mesh MODELFILE=models\BushSprite11Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite11Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite11Anims ANIMFILE=models\BushSprite11Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite11Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite11Mesh ANIM=BushSprite11Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite11Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite11Tex0  FILE=TEXTURES\BushSprite11Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite11Mesh NUM=0 TEXTURE=BushSprite11Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushBranches02.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite11Mesh'
}
