//===============================================================================
//  [voldchallengepillarBroken] 
//===============================================================================

class voldchallengepillarBroken extends HProps;
#exec MESH  MODELIMPORT MESH=voldchallengepillarBrokenMesh MODELFILE=models\voldchallengepillarBrokenMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=voldchallengepillarBrokenMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=voldchallengepillarBrokenAnims ANIMFILE=models\voldchallengepillarBrokenAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=voldchallengepillarBrokenMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=voldchallengepillarBrokenMesh ANIM=voldchallengepillarBrokenAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=voldchallengepillarBrokenAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=voldchallengepillarBrokenTex0  FILE=TEXTURES\voldchallengepillarBrokenTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=voldchallengepillarBrokenMesh NUM=0 TEXTURE=voldchallengepillarBrokenTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: volpilarbrk_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\pillar

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.voldchallengepillarBrokenMesh'
}
