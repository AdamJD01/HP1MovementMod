//===============================================================================
//  [HagridTeaCup] 
//===============================================================================

class HagridTeaCup extends HProps;
#exec MESH  MODELIMPORT MESH=HagridTeaCupMesh MODELFILE=models\HagridTeaCupMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HagridTeaCupMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HagridTeaCupAnims ANIMFILE=models\HagridTeaCupAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HagridTeaCupMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HagridTeaCupMesh ANIM=HagridTeaCupAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HagridTeaCupAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HagridTeaCupTex0  FILE=TEXTURES\HagridTeaCupTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=HagridTeaCupTex1  FILE=TEXTURES\HagridTeaCupTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HagridTeaCupMesh NUM=0 TEXTURE=HagridTeaCupTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=HagridTeaCupMesh NUM=1 TEXTURE=HagridTeaCupTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: hgteacup_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\Teaset 
// Original material [1] is [SKIN01.MASKED] SkinIndex: 1 Bitmap: hgteacup_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\Teaset

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HagridTeaCupMesh'
}
