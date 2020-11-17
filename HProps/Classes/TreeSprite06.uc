//===============================================================================
//  [TreeSprite06] 
//===============================================================================

class TreeSprite06 extends HProps;
#exec MESH  MODELIMPORT MESH=TreeSprite06Mesh MODELFILE=models\TreeSprite06Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TreeSprite06Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TreeSprite06Anims ANIMFILE=models\TreeSprite06Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TreeSprite06Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TreeSprite06Mesh ANIM=TreeSprite06Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TreeSprite06Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TreeSprite06Tex0  FILE=TEXTURES\TreeSprite06Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TreeSprite06Mesh NUM=0 TEXTURE=TreeSprite06Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: TreeSprite06.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TreeSprite06Mesh'
}
