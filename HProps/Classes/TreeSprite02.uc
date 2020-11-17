//===============================================================================
//  [TreeSprite02] 
//===============================================================================

class TreeSprite02 extends HProps;
#exec MESH  MODELIMPORT MESH=TreeSprite02Mesh MODELFILE=models\TreeSprite02Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TreeSprite02Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TreeSprite02Anims ANIMFILE=models\TreeSprite02Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TreeSprite02Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TreeSprite02Mesh ANIM=TreeSprite02Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TreeSprite02Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TreeSprite02Tex0  FILE=TEXTURES\TreeSprite02Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TreeSprite02Mesh NUM=0 TEXTURE=TreeSprite02Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: TreeSprite02.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TreeSprite02Mesh'
}
