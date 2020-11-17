//===============================================================================
//  [voldmortchallengepillar] 
//===============================================================================

class voldmortchallengepillar extends hprops;
#exec MESH  MODELIMPORT MESH=voldmortchallengepillarMesh MODELFILE=models\voldmortchallengepillarMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=voldmortchallengepillarMesh X=0 Y=0 Z=128 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=voldmortchallengepillarAnims ANIMFILE=models\voldmortchallengepillarAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=voldmortchallengepillarMesh X=0.75 Y=0.75 Z=1.0
#exec MESH  DEFAULTANIM MESH=voldmortchallengepillarMesh ANIM=voldmortchallengepillarAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=voldmortchallengepillarAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=voldmortchallengepillarTex0  FILE=TEXTURES\voldmortchallengepillarTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=voldmortchallengepillarMesh NUM=0 TEXTURE=voldmortchallengepillarTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: volpilar_256.bmp  Path: C:\POTTER\Art\Objects\VOLDEMORT CHALLENGE\pillar

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.voldmortchallengepillarMesh'
}
