//===============================================================================
//  [BedDudley] 
//===============================================================================

class BedDudley extends DProps;
#exec MESH  MODELIMPORT MESH=BedDudleyMesh MODELFILE=models\BedDudley.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BedDudleyMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BedDudleyAnims ANIMFILE=models\BedDudley.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BedDudleyMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BedDudleyMesh ANIM=BedDudleyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BedDudleyAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=BedDudleyTex0  FILE=TEXTURES\BedDudleyTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BedDudleyMesh NUM=0 TEXTURE=BedDudleyTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: BedDudley_256.bmp  Path: C:\UNREAL\DProps\Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'DProps.BedDudleyMesh'
}
