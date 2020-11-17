//===============================================================================
//  [voldChallengeBrokeGargoyle2] 
//===============================================================================

class voldChallengeBrokeGargoyle2 extends HProps;
#exec MESH  MODELIMPORT MESH=voldChallengeBrokeGargoyle2Mesh MODELFILE=models\voldChallengeBrokeGargoyle2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=voldChallengeBrokeGargoyle2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=voldChallengeBrokeGargoyle2Anims ANIMFILE=models\voldChallengeBrokeGargoyle2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=voldChallengeBrokeGargoyle2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=voldChallengeBrokeGargoyle2Mesh ANIM=voldChallengeBrokeGargoyle2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=voldChallengeBrokeGargoyle2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=voldChallengeBrokeGargoyle2Tex0  FILE=TEXTURES\voldChallengeBrokeGargoyle2Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=voldChallengeBrokeGargoyle2Tex1  FILE=TEXTURES\voldChallengeBrokeGargoyle2Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=voldChallengeBrokeGargoyle2Mesh NUM=0 TEXTURE=voldChallengeBrokeGargoyle2Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=voldChallengeBrokeGargoyle2Mesh NUM=1 TEXTURE=voldChallengeBrokeGargoyle2Tex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: vldgoyle_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\Gargoyle 
// Original material [1] is [SKIN01.MASKED] SkinIndex: 1 Bitmap: vldgoyle_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\Gargoyle

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.voldChallengeBrokeGargoyle2Mesh'
}
