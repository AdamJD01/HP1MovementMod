//=============================================================================
// BroomHoopStage5 -- A hoop for broom training stage 5
//=============================================================================
class BroomHoopStage5 extends BroomHoop;

function PreBeginPlay()
{
	Super.PreBeginPlay();

	// Load hoop skin texture and declare which stage it's for
	Skin = Texture( DynamicLoadObject("HP_BroomTraining.TrainingHoop.BTStage5", class'FireTexture') );
	Stage=5;
}

defaultproperties
{
     Stage=5
     PlayScale=0.667
     bBobbing=True
     attachedParticleClass=Class'HPParticle.Ring5'
     Group=Stage5
     CollisionRadius=50
     CollisionHeight=50
}
