//===============================================================================
//  [OwlStatue] 
//===============================================================================

class OwlStatue extends HProps;
#exec MESH  MODELIMPORT MESH=OwlStatueMesh MODELFILE=models\OwlStatueMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=OwlStatueMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=OwlStatueAnims ANIMFILE=models\OwlStatueAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=OwlStatueMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=OwlStatueMesh ANIM=OwlStatueAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=OwlStatueAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=OwlStatueTex0  FILE=TEXTURES\OwlStatueTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=OwlStatueMesh NUM=0 TEXTURE=OwlStatueTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: OwlStatue.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.OwlStatueMesh'
}
