//===============================================================================
//  [CaveBug] 
//===============================================================================

class CaveBug extends HProps;
#exec MESH  MODELIMPORT MESH=CaveBugMesh MODELFILE=models\CaveBugMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=CaveBugMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=CaveBugAnims ANIMFILE=models\CaveBugAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=CaveBugMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=CaveBugMesh ANIM=CaveBugAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=CaveBugAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=CaveBugTex0  FILE=TEXTURES\CaveBugTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=CaveBugMesh NUM=0 TEXTURE=CaveBugTex0

// Original material [0] is [skin00.MASKED] SkinIndex: 0 Bitmap: CaveBug.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.CaveBugMesh'
}
