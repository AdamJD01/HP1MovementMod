//===============================================================================
//  [voldChallengeWholeGargoyle] 
//===============================================================================

class voldChallengeWholeGargoyle extends HProps;
#exec MESH  MODELIMPORT MESH=voldChallengeWholeGargoyleMesh MODELFILE=models\voldChallengeWholeGargoyleMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=voldChallengeWholeGargoyleMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=voldChallengeWholeGargoyleAnims ANIMFILE=models\voldChallengeWholeGargoyleAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=voldChallengeWholeGargoyleMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=voldChallengeWholeGargoyleMesh ANIM=voldChallengeWholeGargoyleAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=voldChallengeWholeGargoyleAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=voldChallengeWholeGargoyleTex0  FILE=TEXTURES\voldChallengeWholeGargoyleTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=voldChallengeWholeGargoyleTex1  FILE=TEXTURES\voldChallengeWholeGargoyleTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=voldChallengeWholeGargoyleMesh NUM=0 TEXTURE=voldChallengeWholeGargoyleTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=voldChallengeWholeGargoyleMesh NUM=1 TEXTURE=voldChallengeWholeGargoyleTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: vldgoyle_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\Gargoyle 
// Original material [1] is [SKIN01.MASKED] SkinIndex: 1 Bitmap: vldgoyle_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\Gargoyle

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.voldChallengeWholeGargoyleMesh'
}
