//===============================================================================
//  [skdudley] 
//===============================================================================

class skdudley extends dudley;
//#EXEC MESH  MODELIMPORT MESH=skdudleyMesh MODELFILE=models\skdudley.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skdudleyMesh X=0 Y=0 Z=40 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skdudleyAnims ANIMFILE=models\skdudley.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skdudleyMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skdudleyMesh ANIM=skdudleyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skdudleyAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skdudleyTex0  FILE=TEXTURES\Dudley_SKIN00.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skdudleyMesh NUM=0 TEXTURE=skdudleyTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: Dudley_SKIN00.bmp  Path: \\Baker\HPotterPC\Art\Design\Character Development\Dudley 



//#EXEC MESH WEAPONATTACH MESH=skdudleyMesh BONE="RightHand"
//#EXEC MESH WEAPONPOSITION MESH=skdudleyMesh YAW=0 PITCH=0 ROLL=10 X=0.0 Y=0.0 Z=0.0

defaultproperties
{
}
