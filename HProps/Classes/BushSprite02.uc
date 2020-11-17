//===============================================================================
//  [BushSprite02] 
//===============================================================================

class BushSprite02 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite02Mesh MODELFILE=models\BushSprite02Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite02Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite02Anims ANIMFILE=models\BushSprite02Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite02Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite02Mesh ANIM=BushSprite02Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite02Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite02Tex0  FILE=TEXTURES\BushSprite02Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite02Mesh NUM=0 TEXTURE=BushSprite02Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushSprite02.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite02Mesh'
}
