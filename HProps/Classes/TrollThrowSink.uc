//===============================================================================
//  [TrollThrowSink] 
//===============================================================================

class TrollThrowSink extends BaseToiletObject;
#exec MESH  MODELIMPORT MESH=TrollThrowSinkMesh MODELFILE=models\TrollThrowSinkMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollThrowSinkMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollThrowSinkAnims ANIMFILE=models\TrollThrowSinkAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollThrowSinkMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollThrowSinkMesh ANIM=TrollThrowSinkAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollThrowSinkAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollThrowSinkTex0  FILE=TEXTURES\TrollThrowSinkTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollThrowSinkMesh NUM=0 TEXTURE=TrollThrowSinkTex0

// Original material [0] is [sink_skinn00.MASKED] SkinIndex: 0 Bitmap: TrollThrowSink.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     iDamage=15
     Mesh=SkeletalMesh'HProps.TrollThrowSinkMesh'
}
