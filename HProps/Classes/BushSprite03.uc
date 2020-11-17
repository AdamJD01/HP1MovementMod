//===============================================================================
//  [BushSprite03] 
//===============================================================================

class BushSprite03 extends HProps;
#exec MESH  MODELIMPORT MESH=BushSprite03Mesh MODELFILE=models\BushSprite03Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BushSprite03Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BushSprite03Anims ANIMFILE=models\BushSprite03Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BushSprite03Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BushSprite03Mesh ANIM=BushSprite03Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BushSprite03Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=BushSprite03Tex0  FILE=TEXTURES\BushSprite03Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BushSprite03Mesh NUM=0 TEXTURE=BushSprite03Tex0

// Original material [0] is [skin00.MASKED] SkinIndex: 0 Bitmap: BushSprite03.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BushSprite03Mesh'
}
