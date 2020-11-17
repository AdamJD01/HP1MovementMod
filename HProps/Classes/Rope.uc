//===============================================================================
//  [Rope] 
//===============================================================================

class Rope extends HProps;
#exec MESH  MODELIMPORT MESH=RopeMesh MODELFILE=models\RopeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=RopeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=RopeAnims ANIMFILE=models\RopeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=RopeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=RopeMesh ANIM=RopeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=RopeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=RopeTex0  FILE=TEXTURES\RopeTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=RopeMesh NUM=0 TEXTURE=RopeTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: Rope.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.RopeMesh'
}
