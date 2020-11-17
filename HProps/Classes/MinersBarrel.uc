//===============================================================================
//  [MinersBarrel] 
//===============================================================================

class MinersBarrel extends HProps;
#exec MESH  MODELIMPORT MESH=MinersBarrelMesh MODELFILE=models\MinersBarrelMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=MinersBarrelMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=MinersBarrelAnims ANIMFILE=models\MinersBarrelAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=MinersBarrelMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=MinersBarrelMesh ANIM=MinersBarrelAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=MinersBarrelAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=MinersBarrelTex0  FILE=TEXTURES\MinersBarrelTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=MinersBarrelMesh NUM=0 TEXTURE=MinersBarrelTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: MinersBarrel.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.MinersBarrelMesh'
}
