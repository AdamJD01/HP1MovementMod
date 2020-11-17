//===============================================================================
//  [NullMesh] 
//===============================================================================

class NullMesh extends baseProps;
#exec MESH  MODELIMPORT MESH=NullMeshMesh MODELFILE=models\NullMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=NullMeshMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=NullMeshAnims ANIMFILE=models\NullMesh.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=NullMeshMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=NullMeshMesh ANIM=NullMeshAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=NullMeshAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=NullMeshTex0  FILE=TEXTURES\NullMeshTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=NullMeshMesh NUM=0 TEXTURE=NullMeshTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: ectopgoo_64.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\Ectoplasmic Goo

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPBase.NullMeshMesh'
}
