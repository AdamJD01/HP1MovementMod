//===============================================================================
//  [skorangesnail] 
//===============================================================================

class skorangesnail extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skorangesnailMesh MODELFILE=models\skorangesnail.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skorangesnailMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skorangesnailAnims ANIMFILE=models\skorangesnail.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skorangesnailMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skorangesnailMesh ANIM=skorangesnailAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skorangesnailAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skorangesnailTex0  FILE=TEXTURES\SNAIL_SKIN00.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skorangesnailMesh NUM=0 TEXTURE=skorangesnailTex0

// Original material [0] is [SNAIL_SKIN00] SkinIndex: 0 Bitmap: SNAIL_SKIN00.bmp  Path: C:\POTTER\Art\Characters\OrangeSnail

defaultproperties
{
}
