//===============================================================================
//  [FirTree] 
//===============================================================================

class FirTree extends HProps;
#exec MESH  MODELIMPORT MESH=FirTreeMesh MODELFILE=models\FirTreeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FirTreeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FirTreeAnims ANIMFILE=models\FirTreeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FirTreeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FirTreeMesh ANIM=FirTreeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FirTreeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FirTreeTex0  FILE=TEXTURES\FirTreeTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=FirTreeTex1  FILE=TEXTURES\FirTreeTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FirTreeMesh NUM=0 TEXTURE=FirTreeTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=FirTreeMesh NUM=1 TEXTURE=FirTreeTex1

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: FirtreeBark.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [skin01.MASKED] SkinIndex: 1 Bitmap: FirtreeBows.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FirTreeMesh'
}
