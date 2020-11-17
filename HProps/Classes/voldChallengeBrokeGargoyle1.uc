//===============================================================================
//  [voldChallengeBrokeGargoyle1] 
//===============================================================================

class voldChallengeBrokeGargoyle1 extends HProps;
#exec MESH  MODELIMPORT MESH=voldChallengeBrokeGargoyle1Mesh MODELFILE=models\voldChallengeBrokeGargoyle1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=voldChallengeBrokeGargoyle1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=voldChallengeBrokeGargoyle1Anims ANIMFILE=models\voldChallengeBrokeGargoyle1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=voldChallengeBrokeGargoyle1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=voldChallengeBrokeGargoyle1Mesh ANIM=voldChallengeBrokeGargoyle1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=voldChallengeBrokeGargoyle1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=voldChallengeBrokeGargoyle1Tex0  FILE=TEXTURES\voldChallengeBrokeGargoyle1Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=voldChallengeBrokeGargoyle1Tex1  FILE=TEXTURES\voldChallengeBrokeGargoyle1Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=voldChallengeBrokeGargoyle1Mesh NUM=0 TEXTURE=voldChallengeBrokeGargoyle1Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=voldChallengeBrokeGargoyle1Mesh NUM=1 TEXTURE=voldChallengeBrokeGargoyle1Tex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: vldgoyle_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\Gargoyle 
// Original material [1] is [SKIN01.MASKED] SkinIndex: 1 Bitmap: vldgoyle_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\Gargoyle

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.voldChallengeBrokeGargoyle1Mesh'
}
