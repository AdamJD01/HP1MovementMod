//===============================================================================
//  [BushSprite13] 
//===============================================================================

class BushSprite13 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite13Mesh MODELFILE=models\BushSprite13Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite13Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite13Anims ANIMFILE=models\BushSprite13Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite13Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite13Mesh ANIM=BushSprite13Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite13Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite13Tex0  FILE=TEXTURES\BushSprite13Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite13Mesh NUM=0 TEXTURE=BushSprite13Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushBranches04.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite13Mesh'
}
