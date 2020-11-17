//===============================================================================
//  [BushSprite08] 
//===============================================================================

class BushSprite08 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite08Mesh MODELFILE=models\BushSprite08Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite08Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite08Anims ANIMFILE=models\BushSprite08Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite08Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite08Mesh ANIM=BushSprite08Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite08Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite08Tex0  FILE=TEXTURES\BushSprite08Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite08Mesh NUM=0 TEXTURE=BushSprite08Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushSprite08.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite08Mesh'
}
