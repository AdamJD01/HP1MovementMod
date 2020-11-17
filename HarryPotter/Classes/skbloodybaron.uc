//===============================================================================
//  [skbloodybaron] 
//===============================================================================

class skbloodybaron extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skbloodybaronMesh MODELFILE=models\skbloodybaron.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skbloodybaronMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skbloodybaronAnims ANIMFILE=models\skbloodybaron.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skbloodybaronMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skbloodybaronMesh ANIM=skbloodybaronAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skbloodybaronAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skbloodybaronTex0  FILE=TEXTURES\BARON_SKIN00.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skbloodybaronMesh NUM=0 TEXTURE=skbloodybaronTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: BARON_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\BloodyBaron

defaultproperties
{
}
