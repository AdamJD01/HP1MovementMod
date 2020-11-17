//===============================================================================
//  [ChristmasOrnamentStar] 
//===============================================================================

class ChristmasOrnamentStar extends HProps;
#exec MESH  MODELIMPORT MESH=ChristmasOrnamentStarMesh MODELFILE=models\ChristmasOrnamentStarMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ChristmasOrnamentStarMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ChristmasOrnamentStarAnims ANIMFILE=models\ChristmasOrnamentStarAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ChristmasOrnamentStarMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ChristmasOrnamentStarMesh ANIM=ChristmasOrnamentStarAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ChristmasOrnamentStarAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ChristmasOrnamentStarTex0  FILE=TEXTURES\ChristmasOrnamentStarTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ChristmasOrnamentStarMesh NUM=0 TEXTURE=ChristmasOrnamentStarTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: christar_64.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\Christmas ornaments

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ChristmasOrnamentStarMesh'
}
