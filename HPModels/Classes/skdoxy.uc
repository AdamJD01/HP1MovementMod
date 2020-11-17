//===============================================================================
//  [skdoxy] 
//===============================================================================

class skdoxy extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skdoxyMesh MODELFILE=models\skdoxyMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skdoxyMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skdoxyAnims ANIMFILE=models\skdoxyAnims.PSA COMPRESS=1 MAXKEYS=999999
#exec MESHMAP   SCALE MESHMAP=skdoxyMesh X=1.0 Y=1.0 Z=1.0

// Animation sequences. These can replace or override the implicit (exporter-defined) sequences.
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=hover STARTFRAME=0 NUMFRAMES=24 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=hover_to_attack STARTFRAME=24 NUMFRAMES=37 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=attack STARTFRAME=61 NUMFRAMES=12 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=attack_to_hover STARTFRAME=73 NUMFRAMES=18 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=hover_to_spin STARTFRAME=91 NUMFRAMES=8 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=spin STARTFRAME=99 NUMFRAMES=14 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=spin_to_dizzy STARTFRAME=113 NUMFRAMES=5 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=dizzy_to_hover STARTFRAME=118 NUMFRAMES=24 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=hover_to_fly STARTFRAME=142 NUMFRAMES=6 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=fly STARTFRAME=148 NUMFRAMES=24 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=menacing STARTFRAME=172 NUMFRAMES=24 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=fly_to_hover STARTFRAME=196 NUMFRAMES=36 RATE=30.0000 COMPRESS=1.00 GROUP=None 
#EXEC ANIM  SEQUENCE ANIM=skdoxyAnims SEQ=dizzy STARTFRAME=232 NUMFRAMES=24 RATE=30.0000 COMPRESS=1.00 GROUP=None 

#exec MESH  DEFAULTANIM MESH=skdoxyMesh ANIM=skdoxyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skdoxyAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skdoxyTex0  FILE=TEXTURES\skdoxyTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdoxyTex1  FILE=TEXTURES\skdoxyTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skdoxyMesh NUM=0 TEXTURE=skdoxyTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skdoxyMesh NUM=1 TEXTURE=skdoxyTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: DOXY_SKIN00.bmp  Path: C:\POTTER\Art\Characters\Doxy 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: DOXY_SKIN01.bmp  Path: C:\POTTER\Art\Characters\Doxy

defaultproperties
{
}
