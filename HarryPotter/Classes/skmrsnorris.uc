//===============================================================================
//  [skmrsnorris] 
//===============================================================================

class skmrsnorris extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skmrsnorrisMesh MODELFILE=models\skmrsnorris.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skmrsnorrisMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skmrsnorrisAnims ANIMFILE=models\skmrsnorris.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skmrsnorrisMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skmrsnorrisMesh ANIM=skmrsnorrisAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skmrsnorrisAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skmrsnorrisTex0  FILE=TEXTURES\Norris_Skin00.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skmrsnorrisMesh NUM=0 TEXTURE=skmrsnorrisTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: Norris_Skin00.bmp  Path: C:\POTTER\Art\Characters\Mrs. Norris

defaultproperties
{
}
