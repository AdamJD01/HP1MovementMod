//=============================================================================
// BroomHooch -- Broom practice teacher
//=============================================================================
class BroomHooch extends baseChar;

var BroomHarry		Harry;

enum HoochComment		// If changed, update const, array, and defaultproperties below
{
	HC_None,

	HC_SmallerHoops,	// For use at completion of stages
	HC_Height,
	HC_Challenge,
	HC_MovingHoops,

	HC_KeepEyeOnHoop,	// For use at other points in hoop trial
	HC_WellDone,
	HC_NaturalTalent,
	HC_BonusPoints,
	HC_Gently,
	HC_WatchYourself
};

struct CommentInfo {
	var String		DlgName;				// Name used to looup dialog assets for comment
	var Sound		DlgSound;				// Sound asset for comment
	var String		DlgText;				// Display text for comment
	var bool		bHasBeenSaid;			// Has comment already been said before
	var bool		bRepeatable;			// Can comment be said again
	var float		fTimeLastSaid;			// When was it last said
};

const HC_NUM_COMMENTS = 11;
var CommentInfo	Comments[11];				// Info on all the comments Hooch can make

const fMinTimeBeforeCommentRepeat = 60.0;	// How much time must elapse before comment can be said again


//-------------------------------------------------------------------------------------------
// PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PostBeginPlay()
{
	// Initialize Hooch
	Super.PostBeginPlay();
	SetPhysics(PHYS_FLYING);
	LoopAnim('Hover');

	// Find Harry
	foreach AllActors( class'BroomHarry', Harry )
		break;
}

//-------------------------------------------------------------------------------------------
// Dialog functions
//-------------------------------------------------------------------------------------------

function bool SayComment( HoochComment eComment, optional bool bEvenIfSaidBefore )
{
	// Makes Hooch say the indicated comment.  Will only say the comment if it
	// hasn't been before (or recently, if its repeatable), but it will be
	// said anyway if the optional bEvenIfSaidBefore parameter is True.
	// Returns True if comment was actually said.

	local bool	bSaid;

	bSaid = false;
	if ( eComment == HC_None )
		return false;

	if (    bEvenIfSaidBefore
		 || !Comments[ eComment ].bHasBeenSaid
		 || (    Comments[ eComment ].bRepeatable
		      && Level.TimeSeconds > Comments[ eComment ].fTimeLastSaid + fMinTimeBeforeCommentRepeat ) )
	{
		if ( Comments[ eComment ].DlgSound == None )
			Harry.TheNarrator.FindDialog( Comments[ eComment ].DlgName,
										  Comments[ eComment ].DlgSound,
										  Comments[ eComment ].DlgText );

		if ( Comments[ eComment ].DlgSound != None )
		{
			PlaySound( Comments[ eComment ].DlgSound, SLOT_Talk, , , 10000.0 );	// Radius makes sure she can be heard far away
			bSaid = true;
			Comments[ eComment ].bHasBeenSaid = true;
			Comments[ eComment ].fTimeLastSaid = Level.TimeSeconds;
		}
	}

	return bSaid;
}

function BlowWhistle()
{
	// Makes Hooch blow her whistle (at least make the sound of it).
	PlaySound( Sound'HPSounds.Quidditch_sfx.Q_Whistle_Short', SLOT_Interact, , , 10000.0 );	// Radius makes sure she can be heard far away
}

defaultproperties
{
     Comments(1)=(DlgName="HOOCH_010")
     Comments(2)=(DlgName="HOOCH_011")
     Comments(3)=(DlgName="HOOCH_013")
     Comments(4)=(DlgName="HOOCH_012")
     Comments(5)=(DlgName="HOOCH_004",bRepeatable=True)
     Comments(6)=(DlgName="HOOCH_005",bRepeatable=True)
     Comments(7)=(DlgName="HOOCH_006",bRepeatable=True)
     Comments(8)=(DlgName="HOOCH_007",bRepeatable=True)
     Comments(9)=(DlgName="HOOCH_008",bRepeatable=True)
     Comments(10)=(DlgName="HOOCH_009",bRepeatable=True)
     ShadowClass=Class'HarryPotter.BroomShadow'
     bCutFlying=True
     AirSpeed=350
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skbroomhoochMesh'
     bAlignBottom=False
}
