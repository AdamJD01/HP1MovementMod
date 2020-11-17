//===============================================================================
//  [ChristmasOrnamentBird] 
//===============================================================================

class ChristmasOrnamentBird extends HProps;
#exec MESH  MODELIMPORT MESH=ChristmasOrnamentBirdMesh MODELFILE=models\ChristmasOrnamentBirdMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ChristmasOrnamentBirdMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ChristmasOrnamentBirdAnims ANIMFILE=models\ChristmasOrnamentBirdAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ChristmasOrnamentBirdMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ChristmasOrnamentBirdMesh ANIM=ChristmasOrnamentBirdAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ChristmasOrnamentBirdAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ChristmasOrnamentBirdTex0  FILE=TEXTURES\ChristmasOrnamentBirdTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ChristmasOrnamentBirdMesh NUM=0 TEXTURE=ChristmasOrnamentBirdTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: xmasbird_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\Christmas ornaments

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ChristmasOrnamentBirdMesh'
}
