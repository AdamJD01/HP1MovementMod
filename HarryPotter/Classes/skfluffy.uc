//===============================================================================
//  [skfluffy] 
//===============================================================================

class skfluffy extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skfluffyMesh MODELFILE=models\skfluffy.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skfluffyMesh X=70 Y=0 Z=60 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skfluffyAnims ANIMFILE=models\skfluffy.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skfluffyMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skfluffyMesh ANIM=skfluffyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skfluffyAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skfluffyTex0  FILE=TEXTURES\FLUFFY_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skfluffyTex1  FILE=TEXTURES\FLUFFY_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skfluffyMesh NUM=0 TEXTURE=skfluffyTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skfluffyMesh NUM=1 TEXTURE=skfluffyTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: FLUFFY_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Fluffy 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: FLUFFY_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Fluffy 

// Attack notifications.
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullAtttackLeft   TIME=0.5 FUNCTION=AttackRearFinish
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullAtttackLeft2  TIME=0.5 FUNCTION=AttackRearFinish
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullAtttackMid    TIME=0.5 FUNCTION=AttackRearFinish
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullAtttackRight  TIME=0.5 FUNCTION=AttackRearFinish
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullAtttackRight2 TIME=0.5 FUNCTION=AttackRearFinish

//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullAtttackLeft   TIME=0.6 FUNCTION=AttackDamage
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullAtttackLeft2  TIME=0.6 FUNCTION=AttackDamage
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullAtttackMid    TIME=0.6 FUNCTION=AttackDamage
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullAtttackRight  TIME=0.6 FUNCTION=AttackDamage
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullAtttackRight2 TIME=0.6 FUNCTION=AttackDamage

//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullGrowl         TIME=0.1   FUNCTION=SoundGrowl
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullBark          TIME=0.25  FUNCTION=SoundBark
//#EXEC ANIM NOTIFY ANIM=skfluffyAnims SEQ=FullBark          TIME=0.5   FUNCTION=SoundBark

defaultproperties
{
}
