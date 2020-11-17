//===============================================================================
//  [BookOnDisplay] 
//===============================================================================

class BookOnDisplay extends HProps;
#exec MESH  MODELIMPORT MESH=BookOnDisplayMesh MODELFILE=models\BookOnDisplayMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BookOnDisplayMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BookOnDisplayAnims ANIMFILE=models\BookOnDisplayAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BookOnDisplayMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BookOnDisplayMesh ANIM=BookOnDisplayAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BookOnDisplayAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=BookOnDisplayTex0  FILE=TEXTURES\BookOnDisplayTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BookOnDisplayMesh NUM=0 TEXTURE=BookOnDisplayTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: bookped2_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\books

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BookOnDisplayMesh'
}
