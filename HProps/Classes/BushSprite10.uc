//===============================================================================
//  [BushSprite10] 
//===============================================================================

class BushSprite10 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite10Mesh MODELFILE=models\BushSprite10Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite10Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite10Anims ANIMFILE=models\BushSprite10Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite10Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite10Mesh ANIM=BushSprite10Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite10Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite10Tex0  FILE=TEXTURES\BushSprite10Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite10Mesh NUM=0 TEXTURE=BushSprite10Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushBranches01.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite10Mesh'
}
