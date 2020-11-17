//===============================================================================
//  [BushSprite07] 
//===============================================================================

class BushSprite07 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite07Mesh MODELFILE=models\BushSprite07Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite07Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite07Anims ANIMFILE=models\BushSprite07Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite07Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite07Mesh ANIM=BushSprite07Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite07Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite07Tex0  FILE=TEXTURES\BushSprite07Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite07Mesh NUM=0 TEXTURE=BushSprite07Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushSprite07.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite07Mesh'
}
