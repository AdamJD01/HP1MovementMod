//===============================================================================
//  [HagridBigChair] 
//===============================================================================

class HagridBigChair extends HProps;
#exec MESH  MODELIMPORT MESH=HagridBigChairMesh MODELFILE=models\HagridBigChairMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HagridBigChairMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HagridBigChairAnims ANIMFILE=models\HagridBigChairAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HagridBigChairMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HagridBigChairMesh ANIM=HagridBigChairAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HagridBigChairAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HagridBigChairTex0  FILE=TEXTURES\HagridBigChairTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HagridBigChairMesh NUM=0 TEXTURE=HagridBigChairTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: hagchair_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\Chair

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HagridBigChairMesh'
}
