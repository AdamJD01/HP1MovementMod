//===============================================================================
//  [TreeSprite03] 
//===============================================================================

class TreeSprite03 extends HProps;
#exec MESH  MODELIMPORT MESH=TreeSprite03Mesh MODELFILE=models\TreeSprite03Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TreeSprite03Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TreeSprite03Anims ANIMFILE=models\TreeSprite03Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TreeSprite03Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TreeSprite03Mesh ANIM=TreeSprite03Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TreeSprite03Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TreeSprite03Tex0  FILE=TEXTURES\TreeSprite03Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TreeSprite03Mesh NUM=0 TEXTURE=TreeSprite03Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: TreeSprite02.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TreeSprite03Mesh'
}
