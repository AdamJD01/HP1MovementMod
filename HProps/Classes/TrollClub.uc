//===============================================================================
//  [TrollClub] 
//===============================================================================

class TrollClub extends HProps;
#exec MESH  MODELIMPORT MESH=TrollClubMesh MODELFILE=models\TrollClubMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollClubMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollClubAnims ANIMFILE=models\TrollClubAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollClubMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollClubMesh ANIM=TrollClubAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollClubAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollClubTex0  FILE=TEXTURES\TrollClubTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollClubMesh NUM=0 TEXTURE=TrollClubTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: MTroll_SKIN02.bmp  Path: D:\Harry Potter\ART\Characters\Mountain Troll

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TrollClubMesh'
}
