//=============================================================================
// QuidCommentator -- Source of comments made during a quidditch game
//=============================================================================
class QuidCommentator extends baseChar;

var BroomHarry		Harry;

enum QuidComment	// If changed, update size of Comments[] array, and defaultproperties below
{
	QC_None,

	QC_HasQuaffle,			//  1
	QC_Scores,				//  2

	QC_WinsSlyth,			//  3
	QC_WinsAgain,			//  4
	QC_WinsMatch,			//  5
	QC_WinsCup,				//  6

	QC_TheresTheSnitch,		//  7
	QC_HereComesSeeker,		//  8
	QC_ClosingOnSnitch,		//  9
	QC_ClosingOnSnitch2,	// 10
	QC_ReachingForSnitch,	// 11
	QC_MissedSnitch,		// 12
	QC_CaughtSnitch,		// 13
	QC_DontGiveUp,			// 14

	QC_BludgerPursuit,		// 15
	QC_BludgerPursuit_Multi,// 16
	QC_BludgerMiss,			// 17
	QC_BludgerHit,			// 18

	QC_HitNearDeath,		// 19
	QC_HitDying,			// 20
	QC_Dying,				// 21
	QC_Dead,				// 22

	QC_ReturnToFlight,		// 23

	QC_KeeperDives,			// 24
	QC_Block,				// 25
	QC_Foul,				// 26

	QC_Positive,			// 27

	QC_SigningOff,			// 28

	QC_NumComments
};

enum HouseAffiliation	// Must be in same order as in QuidditchReferee.uc
{
	HA_Gryffindor,		// House 0 (also used for generic house)
	HA_Ravenclaw,		// House 1 (also used for generic opponent)
	HA_Hufflepuff,		// House 2
	HA_Slytherin,		// House 3

	HA_NumHouses
};

const HA_Neutral  = 0;	// Used when the specific house isn't important
const HA_Opponent = 1;	// Used to refer to the house of the opponent when the specific house isn't important

enum TeamAffiliation	// What team a comment refers to; must be in same order as in QuidditchReferee.uc
{
	TA_Gryffindor,
	TA_Opponent,
	TA_Neutral,

	TA_NumAffiliations
};

const QC_MAX_COMMENT_VARIANTS = 8;			// If this changes, change Variants[] in struct VarCommentInfo too

struct CommentInfo {
	var String			DlgName;			// Name used to lookup dialog assets for comment
	var Sound			DlgSound;			// Sound asset for comment
	var String			DlgText;			// Display text for comment
	var bool			bHasBeenSaid;		// Has this comment already been said before
	var float			fTimeLastSaid;		// When was it last said
};

struct VarCommentInfo {
	var CommentInfo		Variant[8];			// All interchangable variations of this comment
	var int				Variations;			// How many variations of this comment are there
	var bool			bHasBeenSaid;		// Has any variant of this comment already been said before
	var float			fTimeLastSaid;		// When was any variant last said
};

struct HouseDependentCommentInfo {
	var VarCommentInfo	House[4];			// House-specific variations of this comment
	var bool			bHasBeenSaid;		// Has any house variant of this comment already been said before
	var float			fTimeLastSaid;		// When was any variant last said
};


var HouseDependentCommentInfo	Comments[29];	// Info on all the comments the quidditch commentator can make

var HouseAffiliation	eOpponent;					// Which house is the opponent team affiliated with
var float				fNextTimeACommentCanBeSaid;	// When is it safe to say another comment
var float				fGapTime;					// How much silence to put between comments

const fNoGapTimeBetweenComments  = 0.1;		// Sliver of time between end of last comment and beginning of next when no gap is desired
const fMinGapTimeBetweenComments = 1.0;		// Lowest Minimum time required between end of last comment and beginning of next
const fMaxGapTimeBetweenComments = 2.4;		// Highest Minimum time required between end of last comment and beginning of next

const fMinTimeBeforeCommentRepeat = 45.0;	// How much time must elapse before a certain comment can be said again


//-------------------------------------------------------------------------------------------
// PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PostBeginPlay()
{
	local int	Variant;

	// Initialize commentator
	Super.PostBeginPlay();

	// Find Harry
	foreach AllActors( class'BroomHarry', Harry )
		break;

	fNextTimeACommentCanBeSaid = 0.0;
	fGapTime = 0.0;
}

//-------------------------------------------------------------------------------------------
// Dialog functions
//-------------------------------------------------------------------------------------------

function SetOpponent( HouseAffiliation eNewOpponent )
{
	eOpponent = eNewOpponent;
	Log( "QuidCommentator: Opponent = "$eOpponent$"." );
}

function float TimeLeftUntilSafeToSayAComment( optional bool bNoGap )
{
	local float	fTimeLeft;

	fTimeLeft = fNextTimeACommentCanBeSaid - Level.TimeSeconds + 0.1;
	if ( bNoGap )
		fTimeLeft += fNoGapTimeBetweenComments;
	else
		fTimeLeft += fGapTime;

	return fTimeLeft;
}

function bool CommentHasBeenSaidBefore( QuidComment eComment )
{
	// Returns true if the any variant of the indicated comment has ever been
	// said before.

	return Comments[ eComment ].bHasBeenSaid;
}

function bool SayComment( QuidComment eComment, optional TeamAffiliation eTeam, optional bool bNoGap )
{
	// Makes the quidditch commentator say the indicated comment. Will
	// automatically choose among available interchangable variants.  Will
	// only pick from variants appropriate for indicated team affiliation (if
	// not generic).  May not say the comment if it has been said too recently
	// or the last one (plus a gap) hasn't finished yet.  If bNoGap is true,
	// then the silence gap after last comment doesn't have to be finished.
	// Returns True if comment was actually said.

	local bool				bSaid;
	local HouseAffiliation	eHouse;

	local int				Variant;
	local int				Tied;
	local int				OldestVariant;
	local float				OldestTime;

	local Sound				DlgSound;

	bSaid = false;
	if ( eComment == QC_None )
		return false;

	// Skip comment if too soon to say another one
	if ( bNoGap )
	{
		if ( Level.TimeSeconds < fNextTimeACommentCanBeSaid + fNoGapTimeBetweenComments )
			return false;
	}
	else
	{
		if ( Level.TimeSeconds < fNextTimeACommentCanBeSaid + fGapTime )
			return false;
	}

	// Determine which house the comment is related to
	switch ( eTeam )
	{
		case TA_Gryffindor:	eHouse = HA_Gryffindor;	break;	// Also used for default, non-team-specific comments
		case TA_Opponent:	eHouse = eOpponent;		break;
		case TA_Neutral:	eHouse = HA_Gryffindor;	break;	// Equal to HA_Neutral
	};

	// See if a house-specific comment is available; if not, look for a generic one
	if ( Comments[ eComment ].House[ eHouse ].Variant[ 0 ].DlgName == "" )
	{
		if ( eTeam == TA_Opponent )
		{
			// Try a generic opponent
			eHouse = HA_Ravenclaw;		// Equal to HA_Opponent
			if ( Comments[ eComment ].House[ eHouse ].Variant[ 0 ].DlgName == "" )
			{
				// Try a generic house
				Log( "QuidCommentator: Warning: No opponent-specific comment available for type "$eComment$" comment, house "$eOpponent$"." );
				eHouse = HA_Gryffindor;	// Equal to HA_Neutral
				if ( Comments[ eComment ].House[ eHouse ].Variant[ 0 ].DlgName == "" )
				{
					Log( "QuidCommentator: Could not find a type "$eComment$" comment for house "$eOpponent$"." );
					return false;
				}
			}
		}
		else
		{
			Log( "QuidCommentator: Could not find a type "$eComment$" comment for team "$eTeam$"." );
			return false;
		}
	}

	// Pick a variant (find oldest one; randomize on ties)
	OldestVariant = 0;
	OldestTime = Level.TimeSeconds;
	Tied = 0;
	Variant = 0;
	while (    Variant < QC_MAX_COMMENT_VARIANTS
		    && Comments[ eComment ].House[ eHouse ].Variant[ Variant ].DlgName != "" )
	{
//		Log( "QuidCommentator: Checking dialog for type "$eComment$" comment, variant "$Variant$"; DlgName = "
//			 $Comments[ eComment ].House[ eHouse ].Variant[ Variant ].DlgName$"; HasBeenSaid = "
//			 $Comments[ eComment ].House[ eHouse ].Variant[ Variant ].bHasBeenSaid$"; TimeLastSaid = "
//			 $Comments[ eComment ].House[ eHouse ].Variant[ Variant ].fTimeLastSaid$"." );

		if ( Comments[ eComment ].House[ eHouse ].Variant[ Variant ].bHasBeenSaid )
		{
			if ( Comments[ eComment ].House[ eHouse ].Variant[ Variant ].fTimeLastSaid < OldestTime )
			{
				OldestVariant = Variant;
				OldestTime = Comments[ eComment ].House[ eHouse ].Variant[ Variant ].fTimeLastSaid;
			}
		}
		else
		{
			// Never been said before; randomly break tie among others not said before
			++Tied;
			if ( FRand() <= 1.0/Tied )	// Iteratively gives even weight across all choices so far
			{
				OldestVariant = Variant;
				OldestTime = -1.0;
			}
		}

		++Variant;
	}
	Comments[ eComment ].House[ eHouse ].Variations = Variant;	// Remember count
	Variant = OldestVariant;

	// Say the comment (if not too soon to repeat it)
	if (    !Comments[ eComment ].House[ eHouse ].Variant[ Variant ].bHasBeenSaid
		 || ( Level.TimeSeconds > Comments[ eComment ].House[ eHouse ].Variant[ Variant ].fTimeLastSaid + fMinTimeBeforeCommentRepeat ) )
	{
		if ( Comments[ eComment ].House[ eHouse ].Variant[ Variant ].DlgSound == None )
			Harry.TheNarrator.FindDialog( Comments[ eComment ].House[ eHouse ].Variant[ Variant ].DlgName,
										  Comments[ eComment ].House[ eHouse ].Variant[ Variant ].DlgSound,
										  Comments[ eComment ].House[ eHouse ].Variant[ Variant ].DlgText );

		DlgSound = Comments[ eComment ].House[ eHouse ].Variant[ Variant ].DlgSound;

		if ( DlgSound != None )
		{
			PlaySound( DlgSound, SLOT_Talk, , , 10000.0 );	// Radius makes sure commentator can be heard far away
			bSaid = true;

			// Mark when this comment was said
			Comments[ eComment ].House[ eHouse ].Variant[ Variant ].fTimeLastSaid = Level.TimeSeconds;
			Comments[ eComment ].House[ eHouse ].fTimeLastSaid = Level.TimeSeconds;
			Comments[ eComment ].fTimeLastSaid = Level.TimeSeconds;

			Comments[ eComment ].House[ eHouse ].Variant[ Variant ].bHasBeenSaid = true;
			Comments[ eComment ].House[ eHouse ].bHasBeenSaid = true;
			Comments[ eComment ].bHasBeenSaid = true;

			// Figure out when its safe to say another comment
			fNextTimeACommentCanBeSaid = Level.TimeSeconds + GetSoundDuration( DlgSound );
			fGapTime = FRand() * (fMaxGapTimeBetweenComments-fMinGapTimeBetweenComments) + fMinGapTimeBetweenComments;

//			Log( "QuidCommentator: Said dialog for type "$eComment$" comment; DlgName = "
//				 $Comments[ eComment ].House[ eHouse ].Variant[ Variant ].DlgName$"." );
		}
		else
		{
			Log( "QuidCommentator: Failed to say dialog for type "$eComment$" comment; DlgName = "
				 $Comments[ eComment ].House[ eHouse ].Variant[ Variant ].DlgName$"." );
		}
	}
	else
	{
//		Log( "QuidCommentator: Skipping dialog for type "$eComment$" comment, variant "$Variant$"; DlgName = "
//			 $Comments[ eComment ].House[ eHouse ].Variant[ Variant ].DlgName$"." );
	}

	return bSaid;
}

defaultproperties
{
     Comments(1)=(House[0]=(Variant[0]=(DlgName="127Commentary2"),Variant[1]=(DlgName="127Commentary6"),Variant[2]=(DlgName="127Commentary12"),Variant[3]=(DlgName="127Commentary20")),House[1]=(Variant[0]=(DlgName="127Commentary4"),Variant[1]=(DlgName="127Commentary9"),Variant[2]=(DlgName="127Commentary10"),Variant[3]=(DlgName="127Commentary21")),House[2]=(Variant[0]=(DlgName="127Commentary3"),Variant[1]=(DlgName="127Commentary8"),Variant[2]=(DlgName="127Commentary11"),Variant[3]=(DlgName="127Commentary75")),House[3]=(Variant[0]=(DlgName="127Commentary1"),Variant[1]=(DlgName="127Commentary5"),Variant[2]=(DlgName="127Commentary7"),Variant[3]=(DlgName="127Commentary19")))
     Comments(2)=(House[0]=(Variant[0]=(DlgName="127Commentary13")),House[1]=(Variant[0]=(DlgName="127Commentary14")),House[2]=(Variant[0]=(DlgName="127Commentary15")),House[3]=(Variant[0]=(DlgName="127Commentary74")))
     Comments(3)=(House[0]=(Variant[0]=(DlgName="127Commentary84")))
     Comments(4)=(House[0]=(Variant[0]=(DlgName="127Commentary83")))
     Comments(5)=(House[0]=(Variant[0]=(DlgName="127Commentary82"),Variant[1]=(DlgName="QuidCom_1")),House[1]=(Variant[0]=(DlgName="QuidCom_4")),House[2]=(Variant[0]=(DlgName="QuidCom_3")),House[3]=(Variant[0]=(DlgName="QuidCom_5")))
     Comments(6)=(House[0]=(Variant[0]=(DlgName="QuidCom_2")))
     Comments(7)=(House[0]=(Variant[0]=(DlgName="127Commentary22"),Variant[1]=(DlgName="127Commentary23"),Variant[2]=(DlgName="127Commentary24")))
     Comments(8)=(House[0]=(Variant[0]=(DlgName="127Commentary98"),Variant[1]=(DlgName="127Commentary25"),Variant[2]=(DlgName="127Commentary26"),Variant[3]=(DlgName="127Commentary27")),House[1]=(Variant[0]=(DlgName="127Commentary100")),House[2]=(Variant[0]=(DlgName="127Commentary99")),House[3]=(Variant[0]=(DlgName="127Commentary101")))
     Comments(9)=(House[0]=(Variant[0]=(DlgName="127Commentary28"),Variant[1]=(DlgName="127Commentary29"),Variant[2]=(DlgName="127Commentary79"),Variant[3]=(DlgName="127Commentary80"),Variant[4]=(DlgName="127Commentary81"),Variant[5]=(DlgName="127Commentary85"),Variant[6]=(DlgName="127Commentary86"),Variant[7]=(DlgName="127Commentary95")))
     Comments(10)=(House[0]=(Variant[0]=(DlgName="127Commentary96"),Variant[1]=(DlgName="127Commentary67"),Variant[2]=(DlgName="127Commentary68"),Variant[3]=(DlgName="127Commentary106"),Variant[4]=(DlgName="127Commentary107"),Variant[5]=(DlgName="127Commentary111"),Variant[6]=(DlgName="127Commentary113")))
     Comments(11)=(House[0]=(Variant[1]=(DlgName="127Commentary36"),Variant[2]=(DlgName="127Commentary87")))
     Comments(12)=(House[0]=(Variant[0]=(DlgName="127Commentary30"),Variant[1]=(DlgName="127Commentary31"),Variant[2]=(DlgName="127Commentary32"),Variant[3]=(DlgName="127Commentary33"),Variant[4]=(DlgName="127Commentary34"),Variant[5]=(DlgName="127Commentary69"),Variant[6]=(DlgName="127Commentary109"),Variant[7]=(DlgName="127Commentary78")))
     Comments(13)=(House[0]=(Variant[0]=(DlgName="127Commentary37"),Variant[1]=(DlgName="127Commentary38"),Variant[2]=(DlgName="127Commentary39"),Variant[3]=(DlgName="127Commentary40"),Variant[4]=(DlgName="127Commentary41"),Variant[5]=(DlgName="127Commentary88")))
     Comments(14)=(House[0]=(Variant[0]=(DlgName="127Commentary97")))
     Comments(15)=(House[0]=(Variant[0]=(DlgName="127Commentary43"),Variant[1]=(DlgName="127Commentary47")))
     Comments(16)=(House[0]=(Variant[0]=(DlgName="127Commentary49")))
     Comments(17)=(House[0]=(Variant[0]=(DlgName="127Commentary42"),Variant[1]=(DlgName="127Commentary44"),Variant[2]=(DlgName="127Commentary45")))
     Comments(18)=(House[0]=(Variant[0]=(DlgName="127Commentary46"),Variant[1]=(DlgName="127Commentary48"),Variant[2]=(DlgName="127Commentary73"),Variant[3]=(DlgName="127Commentary77")))
     Comments(19)=(House[0]=(Variant[0]=(DlgName="127Commentary52"),Variant[1]=(DlgName="127Commentary58"),Variant[2]=(DlgName="127Commentary116")))
     Comments(20)=(House[0]=(Variant[0]=(DlgName="127Commentary50")))
     Comments(21)=(House[0]=(Variant[0]=(DlgName="127Commentary51"),Variant[1]=(DlgName="127Commentary53"),Variant[2]=(DlgName="127Commentary54"),Variant[3]=(DlgName="127Commentary112")))
     Comments(22)=(House[0]=(Variant[0]=(DlgName="127Commentary55"),Variant[1]=(DlgName="127Commentary56"),Variant[2]=(DlgName="127Commentary57")))
     Comments(23)=(House[0]=(Variant[0]=(DlgName="127Commentary59"),Variant[1]=(DlgName="127Commentary60"),Variant[2]=(DlgName="127Commentary61")))
     Comments(24)=(House[0]=(Variant[0]=(DlgName="127Commentary17"),Variant[1]=(DlgName="127Commentary18")))
     Comments(25)=(House[0]=(Variant[0]=(DlgName="127Commentary16")))
     Comments(26)=(House[0]=(Variant[0]=(DlgName="127Commentary76")))
     Comments(27)=(House[0]=(Variant[0]=(DlgName="127Commentary104"),Variant[1]=(DlgName="127Commentary105"),Variant[2]=(DlgName="127Commentary108")))
     Comments(28)=(House[0]=(Variant[0]=(DlgName="127Commentary66")))
     eOpponent=HA_Ravenclaw
     bHidden=True
     Texture=Texture'Engine.S_Flag'
}
