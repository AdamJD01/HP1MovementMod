//===============================================================================
//  [MinersPick] 
//===============================================================================

class MinersPick extends HProps;
#exec MESH  MODELIMPORT MESH=MinersPickMesh MODELFILE=models\MinersPickMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=MinersPickMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=MinersPickAnims ANIMFILE=models\MinersPickAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=MinersPickMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=MinersPickMesh ANIM=MinersPickAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=MinersPickAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=MinersPickTex0  FILE=TEXTURES\MinersPickTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=MinersPickMesh NUM=0 TEXTURE=MinersPickTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: MinersPick.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.MinersPickMesh'
}
