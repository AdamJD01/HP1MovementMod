//===============================================================================
//  [PeeveThrowSpoon] 
//===============================================================================

class PeeveThrowSpoon extends HProps;
#exec MESH  MODELIMPORT MESH=PeeveThrowSpoonMesh MODELFILE=models\PeeveThrowSpoonMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PeeveThrowSpoonMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PeeveThrowSpoonAnims ANIMFILE=models\PeeveThrowSpoonAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PeeveThrowSpoonMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PeeveThrowSpoonMesh ANIM=PeeveThrowSpoonAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PeeveThrowSpoonAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PeeveThrowSpoonTex0  FILE=TEXTURES\PeeveThrowSpoonTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PeeveThrowSpoonMesh NUM=0 TEXTURE=PeeveThrowSpoonTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: pvespoon_128.bmp  Path: D:\Harry Potter\Art\Objects\Peeves Throwing Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PeeveThrowSpoonMesh'
}
