//===============================================================================
//  [BushSprite01] 
//===============================================================================

class BushSprite01 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite01Mesh MODELFILE=models\BushSprite01Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite01Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite01Anims ANIMFILE=models\BushSprite01Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite01Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite01Mesh ANIM=BushSprite01Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite01Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite01Tex0  FILE=TEXTURES\BushSprite01Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite01Mesh NUM=0 TEXTURE=BushSprite01Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushSprite01.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite01Mesh'
}
