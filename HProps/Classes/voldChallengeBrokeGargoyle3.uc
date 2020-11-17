//===============================================================================
//  [voldChallengeBrokeGargoyle3] 
//===============================================================================

class voldChallengeBrokeGargoyle3 extends HProps;
#exec MESH  MODELIMPORT MESH=voldChallengeBrokeGargoyle3Mesh MODELFILE=models\voldChallengeBrokeGargoyle3Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=voldChallengeBrokeGargoyle3Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=voldChallengeBrokeGargoyle3Anims ANIMFILE=models\voldChallengeBrokeGargoyle3Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=voldChallengeBrokeGargoyle3Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=voldChallengeBrokeGargoyle3Mesh ANIM=voldChallengeBrokeGargoyle3Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=voldChallengeBrokeGargoyle3Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=voldChallengeBrokeGargoyle3Tex0  FILE=TEXTURES\voldChallengeBrokeGargoyle3Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=voldChallengeBrokeGargoyle3Mesh NUM=0 TEXTURE=voldChallengeBrokeGargoyle3Tex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: vldgoyle_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\Gargoyle

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.voldChallengeBrokeGargoyle3Mesh'
}
