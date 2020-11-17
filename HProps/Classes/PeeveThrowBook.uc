//===============================================================================
//  [PeeveThrowBook] 
//===============================================================================

class PeeveThrowBook extends HProps;
#exec MESH  MODELIMPORT MESH=PeeveThrowBookMesh MODELFILE=models\PeeveThrowBookMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PeeveThrowBookMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PeeveThrowBookAnims ANIMFILE=models\PeeveThrowBookAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PeeveThrowBookMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PeeveThrowBookMesh ANIM=PeeveThrowBookAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PeeveThrowBookAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PeeveThrowBookTex0  FILE=TEXTURES\PeeveThrowBookTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PeeveThrowBookMesh NUM=0 TEXTURE=PeeveThrowBookTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: pevebook_128.bmp  Path: D:\Harry Potter\Art\Objects\Peeves Throwing Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PeeveThrowBookMesh'
}
