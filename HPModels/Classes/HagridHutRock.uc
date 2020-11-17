//===============================================================================
//  [HagridHutRock] 
//===============================================================================

class HagridHutRock extends actor;
#exec MESH  MODELIMPORT MESH=HagridHutRockMesh MODELFILE=models\HagridHutRockMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HagridHutRockMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HagridHutRockAnims ANIMFILE=models\HagridHutRockAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HagridHutRockMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HagridHutRockMesh ANIM=HagridHutRockAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HagridHutRockAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HagridHutRockTex0  FILE=TEXTURES\HagridHutRockTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HagridHutRockMesh NUM=0 TEXTURE=HagridHutRockTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: hutstne1_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.HagridHutRockMesh'
}
