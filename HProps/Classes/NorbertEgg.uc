//===============================================================================
//  [NorbertEgg] 
//===============================================================================

class NorbertEgg extends HProps;
#exec MESH  MODELIMPORT MESH=NorbertEggMesh MODELFILE=models\NorbertEggMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=NorbertEggMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=NorbertEggAnims ANIMFILE=models\NorbertEggAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=NorbertEggMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=NorbertEggMesh ANIM=NorbertEggAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=NorbertEggAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=NorbertEggTex0  FILE=TEXTURES\NorbertEggTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=NorbertEggMesh NUM=0 TEXTURE=NorbertEggTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: NorbertEgg.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.NorbertEggMesh'
}
