//===============================================================================
//  [TreeSprite04] 
//===============================================================================

class TreeSprite04 extends HProps;
#exec MESH  MODELIMPORT MESH=TreeSprite04Mesh MODELFILE=models\TreeSprite04Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TreeSprite04Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TreeSprite04Anims ANIMFILE=models\TreeSprite04Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TreeSprite04Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TreeSprite04Mesh ANIM=TreeSprite04Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TreeSprite04Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TreeSprite04Tex0  FILE=TEXTURES\TreeSprite04Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TreeSprite04Mesh NUM=0 TEXTURE=TreeSprite04Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: TreeSprite04.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TreeSprite04Mesh'
}
