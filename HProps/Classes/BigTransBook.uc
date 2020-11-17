//===============================================================================
//  [BigTransBook] 
//===============================================================================

class BigTransBook extends HProps;
#exec MESH  MODELIMPORT MESH=BigTransBookMesh MODELFILE=models\BigTransBookMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BigTransBookMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BigTransBookAnims ANIMFILE=models\BigTransBookAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BigTransBookMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BigTransBookMesh ANIM=BigTransBookAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BigTransBookAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=BigTransBookTex0  FILE=TEXTURES\BigTransBookTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BigTransBookMesh NUM=0 TEXTURE=BigTransBookTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: tranbook_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects\books

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BigTransBookMesh'
}
