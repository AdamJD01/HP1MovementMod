//===============================================================================
//  [BushSprite06] 
//===============================================================================

class BushSprite06 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite06Mesh MODELFILE=models\BushSprite06Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite06Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite06Anims ANIMFILE=models\BushSprite06Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite06Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite06Mesh ANIM=BushSprite06Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite06Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite06Tex0  FILE=TEXTURES\BushSprite06Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite06Mesh NUM=0 TEXTURE=BushSprite06Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: BushSprite06.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite06Mesh'
}
