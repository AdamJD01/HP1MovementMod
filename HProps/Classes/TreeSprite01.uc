//===============================================================================
//  [TreeSprite01] 
//===============================================================================

class TreeSprite01 extends HProps;
#exec MESH  MODELIMPORT MESH=TreeSprite01Mesh MODELFILE=models\TreeSprite01Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TreeSprite01Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TreeSprite01Anims ANIMFILE=models\TreeSprite01Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TreeSprite01Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TreeSprite01Mesh ANIM=TreeSprite01Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TreeSprite01Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TreeSprite01Tex0  FILE=TEXTURES\TreeSprite01Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TreeSprite01Mesh NUM=0 TEXTURE=TreeSprite01Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: TreeSprite01.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TreeSprite01Mesh'
}
