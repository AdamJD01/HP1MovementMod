//===============================================================================
//  [BushSprite12] 
//===============================================================================

class BushSprite12 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite12Mesh MODELFILE=models\BushSprite12Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite12Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite12Anims ANIMFILE=models\BushSprite12Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite12Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite12Mesh ANIM=BushSprite12Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite12Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite12Tex0  FILE=TEXTURES\BushSprite12Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite12Mesh NUM=0 TEXTURE=BushSprite12Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushBranches03.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite12Mesh'
}
