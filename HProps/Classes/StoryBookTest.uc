//===============================================================================
//  [StoryBookTest] 
//===============================================================================

class StoryBookTest extends HProps;
#exec MESH  MODELIMPORT MESH=StoryBookTestMesh MODELFILE=models\StoryBookTestMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=StoryBookTestMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=StoryBookTestAnims ANIMFILE=models\StoryBookTestAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=StoryBookTestMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=StoryBookTestMesh ANIM=StoryBookTestAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=StoryBookTestAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=StoryBookTestTex0  FILE=TEXTURES\StoryBookTestTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=StoryBookTestTex1  FILE=TEXTURES\StoryBookTestTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=StoryBookTestMesh NUM=0 TEXTURE=StoryBookTestTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=StoryBookTestMesh NUM=1 TEXTURE=StoryBookTestTex1

// Original material [0] is [STORYBOOK.SKIN00] SkinIndex: 0 Bitmap: blankpge.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\books 
// Original material [1] is [STORYBOOK.SKIN01] SkinIndex: 1 Bitmap: floatbok_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\books

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.StoryBookTestMesh'
}
