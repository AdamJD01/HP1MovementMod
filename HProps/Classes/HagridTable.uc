//===============================================================================
//  [HagridTable] 
//===============================================================================

class HagridTable extends HProps;
#exec MESH  MODELIMPORT MESH=HagridTableMesh MODELFILE=models\HagridTableMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HagridTableMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HagridTableAnims ANIMFILE=models\HagridTableAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HagridTableMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HagridTableMesh ANIM=HagridTableAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HagridTableAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HagridTableTex0  FILE=TEXTURES\HagridTableTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=HagridTableTex1  FILE=TEXTURES\HagridTableTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HagridTableMesh NUM=0 TEXTURE=HagridTableTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=HagridTableMesh NUM=1 TEXTURE=HagridTableTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: hagtable_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\Table Chairs 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: hagtable_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\Table Chairs

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HagridTableMesh'
}
