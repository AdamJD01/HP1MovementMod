//===============================================================================
//  [MinersCart] 
//===============================================================================

class MinersCart extends HProps;
#exec MESH  MODELIMPORT MESH=MinersCartMesh MODELFILE=models\MinersCartMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=MinersCartMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=MinersCartAnims ANIMFILE=models\MinersCartAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=MinersCartMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=MinersCartMesh ANIM=MinersCartAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=MinersCartAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=MinersCartTex0  FILE=TEXTURES\MinersCartTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=MinersCartMesh NUM=0 TEXTURE=MinersCartTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: MinersCart.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.MinersCartMesh'
}
