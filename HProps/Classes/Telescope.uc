//===============================================================================
//  [Telescope] 
//===============================================================================

class Telescope extends HProps;
#exec MESH  MODELIMPORT MESH=TelescopeMesh MODELFILE=models\TelescopeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TelescopeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TelescopeAnims ANIMFILE=models\TelescopeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TelescopeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TelescopeMesh ANIM=TelescopeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TelescopeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TelescopeTex0  FILE=TEXTURES\TelescopeTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TelescopeMesh NUM=0 TEXTURE=TelescopeTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: Telescope.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TelescopeMesh'
}
