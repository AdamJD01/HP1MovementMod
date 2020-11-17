//===============================================================================
//  [FSeedChallStalagtite] 
//===============================================================================

class FSeedChallStalagtite extends HProps;
#exec MESH  MODELIMPORT MESH=FSeedChallStalagtiteMesh MODELFILE=models\FSeedChallStalagtiteMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FSeedChallStalagtiteMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FSeedChallStalagtiteAnims ANIMFILE=models\FSeedChallStalagtiteAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FSeedChallStalagtiteMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FSeedChallStalagtiteMesh ANIM=FSeedChallStalagtiteAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FSeedChallStalagtiteAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FSeedChallStalagtiteTex0  FILE=TEXTURES\FSeedChallStalagtiteTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FSeedChallStalagtiteMesh NUM=0 TEXTURE=FSeedChallStalagtiteTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: grayrock_128.bmp  Path: D:\Harry Potter\Art\Objects\Fireseed Challenge

defaultproperties
{
     bStatic=False
     Physics=PHYS_Falling
     eVulnerableToSpell=SPELL_Flipendo
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FSeedChallStalagtiteMesh'
     CollisionRadius=48
     CollisionHeight=128
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
     bProjTarget=True
}
