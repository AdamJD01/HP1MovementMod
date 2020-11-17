//===============================================================================
//  [TrollThrowToilet] 
//===============================================================================

class TrollThrowToilet extends BaseToiletObject;
#exec MESH  MODELIMPORT MESH=TrollThrowToiletMesh MODELFILE=models\TrollThrowToiletMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollThrowToiletMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollThrowToiletAnims ANIMFILE=models\TrollThrowToiletAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollThrowToiletMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollThrowToiletMesh ANIM=TrollThrowToiletAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollThrowToiletAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollThrowToiletTex0  FILE=TEXTURES\TrollThrowToiletTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollThrowToiletMesh NUM=0 TEXTURE=TrollThrowToiletTex0

// Original material [0] is [Toilet_skinn00] SkinIndex: 0 Bitmap: TrollThrowToilet.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 

function explode(vector HitNormal)
{
	local HProps	Fragment;

	ExplosionFX = spawn(class'ChessExplo', [spawnlocation] location);

	Velocity *= 0.75;

	Fragment = spawn(class'TrollThrowToiletBroken1', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));
	
	Fragment = spawn(class'TrollThrowToiletBroken2', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));

	destroy();
}

defaultproperties
{
     iDamage=15
     Mesh=SkeletalMesh'HProps.TrollThrowToiletMesh'
}
