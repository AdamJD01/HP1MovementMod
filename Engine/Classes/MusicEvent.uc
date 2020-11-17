//=============================================================================
// MusicEvent.
//=============================================================================
class MusicEvent extends Triggers;

// Variables.
var() music            Song;
var() byte             SongSection;
var() byte             CdTrack;
var() EMusicTransition Transition;
var() bool             bSilence;
var() bool             bOnceOnly;
var() bool             bAffectAllPlayers;

// Music boost parameters
var (MusicEventBoost) bool bDoBoost;
var (MusicEventBoost) byte  PercentMusicVolume;
var (MusicEventBoost) float BoostTime;
var (MusicEventBoost) EMusicTransition EndTransition;

// Music as trigger parameters
var(MusicEventTrigger) bool bPlayOnceOnly;
var(MusicEventTrigger) name TriggerToSendWhenDone;


var byte PrevPercentMusicVolume;
var float TimeSoFar;
var PlayerPawn P;
var float MusicFade;


// When gameplay starts.
function BeginPlay()
{
	if( Song==None && !bSilence)
	{
		if (!Level.bDisableDefaultSong)
			Song = Level.Song;
	}
	if( bSilence )
	{
		SongSection = 255;
		CdTrack     = 255;
	}
}

// When triggered.
function Trigger( actor Other, pawn EventInstigator )
{
	local Pawn A;
	local PlayerPawn PP;

	if( bAffectAllPlayers )
	{
		A = Level.PawnList;
		While ( A != None )
		{
			PP = PlayerPawn(A);
			if ( PP != None)
			{
				P = pp;

				SetMusic ();
				GotoTriggeredState (false);	
			}
			A = A.nextPawn;
		}
	}
	else
	{
		// Only affect the one player.
		P = PlayerPawn(EventInstigator);
		if( P==None )
			return;
		
		SetMusic ();
		GotoTriggeredState (false);	
	}	

	// Turn off if once-only.
	if( bOnceOnly )
	{
		SetCollision(false,false,false);
		disable( 'Trigger' );
	}
}


function CancelEvent ()
{
//	log("MusicEvent cancelled");
	P.ClientSetPercentMusicVolume(PrevPercentMusicVolume);
	gotostate('untriggered');
}


function SetMusic ()
{
	if (P.currentMusicEvent != None)
		P.currentMusicEvent.CancelEvent ();

	P.ClientSetMusic( Song, SongSection, CdTrack, Transition, bPlayOnceOnly );

	PrevPercentMusicVolume = P.PercentMusicVolume;
	P.currentMusicEvent = self;
}


function GotoTriggeredState (bool bBoostDone)
{
//	log ("MusicEvent GotoTriggeredState");

	if (bDoBoost && !bBoostDone)
	{
		TimeSoFar = 0;

		P.ClientSetPercentMusicVolume(PercentMusicVolume);

//		log("MusicEventBoost Triggered volume boost, from"@ PrevPercentMusicVolume @"to"@ PercentMusicVolume);

		MusicFade = 1.0;
		gotostate('BoostTriggered');
	}
	else
	{
		if (bPlayOnceOnly && TriggerToSendWhenDone != '')
			gotostate('WaitForSongToFinish');
		else
		{
			if (P.currentMusicEvent == self)
				P.currentMusicEvent = None;

			gotostate('untriggered');
		}
	}
}

auto state untriggered
{
	function beginState ()
	{
//		log("MusicEvent new state untriggered");
	}
}


state BoostTriggered
{
	function beginState ()
	{
//		log("MusicEvent new state BoostTriggered");
	}

	function Tick( float DeltaTime )
	{
		local float musicVol;

		TimeSoFar += DeltaTime;

		//log("MusicEventBoost TimeSoFar"@ TimeSoFar @BoostTime);

		if (TimeSoFar > BoostTime)
		{
			switch(EndTransition)
			{
			case MTRAN_None:
			case MTRAN_Instant:
				MusicFade = 0;
				break;

			case MTRAN_Fade:
				MusicFade -= DeltaTime * 1;
				break;

			case MTRAN_FastFade:
				MusicFade -= DeltaTime * 3;
				break;

			case MTRAN_SlowFade:
				MusicFade -= DeltaTime * 0.2;
				break;
			};

			if (MusicFade < 0.0)
				MusicFade = 0.0;

			musicVol = PercentMusicVolume-PrevPercentMusicVolume;
			musicVol *= MusicFade;
			musicVol += PrevPercentMusicVolume;

			P.ClientSetPercentMusicVolume(musicVol);

//			log("MusicEventBoost Triggered volume boost, fade"@ MusicFade @"level"@ musicVol);

			if (MusicFade <= 0.0)
			{
				GotoTriggeredState (true);
			}
		}
	}
}


state WaitForSongToFinish
{
	function Tick( float DeltaTime )
	{
		if (P.bSongFinished)
		{
//			log("MusicEvent Song has finished");

			if (P.currentMusicEvent == self)
				P.currentMusicEvent = None;

			P.TriggerEvent( TriggerToSendWhenDone, none, none );
			if (Tag != TriggerToSendWhenDone)
				gotostate('untriggered');
		}
	}
}

defaultproperties
{
     CdTrack=255
     Transition=MTRAN_Fade
     bAffectAllPlayers=True
     PercentMusicVolume=100
     EndTransition=MTRAN_Fade
}
