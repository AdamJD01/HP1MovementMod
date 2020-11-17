//===============================================================================
//  [XLandingMarkerSpot] 
//===============================================================================

class XLandingMarkerSpot extends HProps;
#exec MESH  MODELIMPORT MESH=XLandingMarkerSpotMesh MODELFILE=models\XLandingMarkerSpotMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=XLandingMarkerSpotMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=XLandingMarkerSpotAnims ANIMFILE=models\XLandingMarkerSpotAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=XLandingMarkerSpotMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=XLandingMarkerSpotMesh ANIM=XLandingMarkerSpotAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=XLandingMarkerSpotAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=XLandingMarkerSpotTex0  FILE=TEXTURES\XLandingMarkerSpotTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=XLandingMarkerSpotMesh NUM=0 TEXTURE=XLandingMarkerSpotTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: landingx_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\X marks the spot

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.XLandingMarkerSpotMesh'
}
