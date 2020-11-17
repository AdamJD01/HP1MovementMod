//===============================================================================
//  [BushSprite04] 
//===============================================================================

class BushSprite04 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite04Mesh MODELFILE=models\BushSprite04Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite04Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite04Anims ANIMFILE=models\BushSprite04Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite04Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite04Mesh ANIM=BushSprite04Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite04Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite04Tex0  FILE=TEXTURES\BushSprite04Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite04Mesh NUM=0 TEXTURE=BushSprite04Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushSprite04.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite04Mesh'
}
