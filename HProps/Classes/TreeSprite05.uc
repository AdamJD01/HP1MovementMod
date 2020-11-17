//===============================================================================
//  [TreeSprite05] 
//===============================================================================

class TreeSprite05 extends HProps;
#exec MESH  MODELIMPORT MESH=TreeSprite05Mesh MODELFILE=models\TreeSprite05Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TreeSprite05Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TreeSprite05Anims ANIMFILE=models\TreeSprite05Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TreeSprite05Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TreeSprite05Mesh ANIM=TreeSprite05Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TreeSprite05Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TreeSprite05Tex0  FILE=TEXTURES\TreeSprite05Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TreeSprite05Mesh NUM=0 TEXTURE=TreeSprite05Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: TreeSprite05.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TreeSprite05Mesh'
}
