//===============================================================================
//  [sksnitch] 
//===============================================================================

class sksnitch extends actor;
#exec MESH  MODELIMPORT MESH=sksnitchMesh MODELFILE=models\sksnitchMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=sksnitchMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=sksnitchAnims ANIMFILE=models\sksnitchAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=sksnitchMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=sksnitchMesh ANIM=sksnitchAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=sksnitchAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=sksnitchTex0  FILE=TEXTURES\sksnitchTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=sksnitchMesh NUM=0 TEXTURE=sksnitchTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: glsnitch_64.bmp  Path: C:\Documents and Settings\dhunt.KNOWWONDER\Desktop\Dhunt\work\Harry Potter

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.sksnitchMesh'
}
