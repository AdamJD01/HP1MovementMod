//===============================================================================
//  [skslytherinkid] 
//===============================================================================

class skslytherinkid extends actor;
#exec MESH  MODELIMPORT MESH=skslytherinkidMesh MODELFILE=models\skslytherinkidMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skslytherinkidMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skslytherinkidAnims ANIMFILE=models\skslytherinkidAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skslytherinkidMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skslytherinkidMesh ANIM=skslytherinkidAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skslytherinkidAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skslytherinkidTex0  FILE=TEXTURES\skslytherinkidTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skslytherinkidTex1  FILE=TEXTURES\skslytherinkidTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skslytherinkidMesh NUM=0 TEXTURE=skslytherinkidTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skslytherinkidMesh NUM=1 TEXTURE=skslytherinkidTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: SLYTHERIN_SKIN00.bmp  Path: C:\potter\Characters 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: SLYTHERIN_SKIN01.bmp  Path: C:\potter\Characters

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skslytherinkidMesh'
}
