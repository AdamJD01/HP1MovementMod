//===============================================================================
//  [skangryflyingkey] 
//===============================================================================

class skangryflyingkey extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skangryflyingkeyMesh MODELFILE=models\skangryflyingkeyMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skangryflyingkeyMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skangryflyingkeyAnims ANIMFILE=models\skangryflyingkeyAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skangryflyingkeyMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skangryflyingkeyMesh ANIM=skangryflyingkeyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skangryflyingkeyAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skangryflyingkeyTex0  FILE=TEXTURES\skangryflyingkeyTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skangryflyingkeyMesh NUM=0 TEXTURE=skangryflyingkeyTex0

// Original material [0] is [FLYINGKEY_SKIN00] SkinIndex: 0 Bitmap: FLYINGKEY_SKIN01.bmp  Path: H:\Art\Design\Creatures\FlyingKey

defaultproperties
{
}
