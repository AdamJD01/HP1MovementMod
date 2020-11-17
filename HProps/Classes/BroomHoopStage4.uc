//=============================================================================
// BroomHoopStage4 -- A hoop for broom training stage 4
//=============================================================================
class BroomHoopStage4 extends BroomHoop;

function PreBeginPlay()
{
	Super.PreBeginPlay();

	// Load hoop skin texture and declare which stage it's for
	Skin = Texture( DynamicLoadObject("HP_BroomTraining.TrainingHoop.BTStage4", class'FireTexture') );
	Stage=4;
}

defaultproperties
{
     Stage=4
     PlayScale=0.667
     attachedParticleClass=Class'HPParticle.Ring4'
     Group=Stage4
     CollisionRadius=50
     CollisionHeight=50
}
