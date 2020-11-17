//===============================================================================
//  [WoodenSpoke] 
//===============================================================================

class WoodenSpoke extends HProps;
#exec MESH  MODELIMPORT MESH=WoodenSpokeMesh MODELFILE=models\WoodenSpokeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=WoodenSpokeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=WoodenSpokeAnims ANIMFILE=models\WoodenSpokeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=WoodenSpokeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=WoodenSpokeMesh ANIM=WoodenSpokeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=WoodenSpokeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=WoodenSpokeTex0  FILE=TEXTURES\WoodenSpokeTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=WoodenSpokeMesh NUM=0 TEXTURE=WoodenSpokeTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: woodspoke.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.WoodenSpokeMesh'
}
