//===============================================================================
//  [Firewood] 
//===============================================================================

class Firewood extends HProps;
#exec MESH  MODELIMPORT MESH=FirewoodMesh MODELFILE=models\FirewoodMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FirewoodMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FirewoodAnims ANIMFILE=models\FirewoodAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FirewoodMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FirewoodMesh ANIM=FirewoodAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FirewoodAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FirewoodTex0  FILE=TEXTURES\FirewoodTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FirewoodMesh NUM=0 TEXTURE=FirewoodTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: firewood.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FirewoodMesh'
}
