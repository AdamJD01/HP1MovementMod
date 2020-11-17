//===============================================================================
//  [BushSprite05] 
//===============================================================================

class BushSprite05 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite05Mesh MODELFILE=models\BushSprite05Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite05Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite05Anims ANIMFILE=models\BushSprite05Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite05Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite05Mesh ANIM=BushSprite05Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite05Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite05Tex0  FILE=TEXTURES\BushSprite05Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite05Mesh NUM=0 TEXTURE=BushSprite05Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushSprite05.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite05Mesh'
}
