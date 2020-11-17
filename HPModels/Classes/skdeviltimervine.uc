//===============================================================================
//  [skdeviltimervine] 
//===============================================================================

class skdeviltimervine extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skdeviltimervineMesh MODELFILE=models\skdeviltimervineMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skdeviltimervineMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skdeviltimervineAnims ANIMFILE=models\skdeviltimervineAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skdeviltimervineMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skdeviltimervineMesh ANIM=skdeviltimervineAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skdeviltimervineAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skdeviltimervineTex0  FILE=TEXTURES\skdeviltimervineTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skdeviltimervineMesh NUM=0 TEXTURE=skdeviltimervineTex0

// Original material [0] is [TIMERVINE_SKIN00] SkinIndex: 0 Bitmap: DEVILTIMERVINE_SKIN00.bmp  Path: H:\Art\Design\Creatures\Devil's Snare

defaultproperties
{
}
