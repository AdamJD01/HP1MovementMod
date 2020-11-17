//===============================================================================
//  [skdevilplant2] 
//===============================================================================

class skdevilplant2 extends actor;
#exec MESH  MODELIMPORT MESH=skdevilplant2Mesh MODELFILE=models\skdevilplant2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skdevilplant2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skdevilplant2Anims ANIMFILE=models\skdevilplant2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skdevilplant2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skdevilplant2Mesh ANIM=skdevilplant2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skdevilplant2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=skdevilplant2Tex0  FILE=TEXTURES\skdevilplant2Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilplant2Tex1  FILE=TEXTURES\skdevilplant2Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilplant2Mesh NUM=0 TEXTURE=skdevilplant2Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilplant2Mesh NUM=1 TEXTURE=skdevilplant2Tex1

// Original material [0] is [DEVILPLANTSKIN00] SkinIndex: 0 Bitmap: DEVILPLANT_SKIN00.bmp  Path: H:\Art\Design\Creatures\Devil's Snare 
// Original material [1] is [DEVILPLANTSKIN01] SkinIndex: 1 Bitmap: DEVILPLANT_SKIN01.bmp  Path: H:\Art\Design\Creatures\Devil's Snare

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skdevilplant2Mesh'
}
