import UnityEngine

class Player(MonoBehaviour): 
	public playerMothership as AIShip

	def Start ():
		pass
	
	def Update ():
		pass

/*
typedef struct Player
{
    Ship *PlayerMothership;
    sdword resourceUnits;
    ShipRace race;
    PlayerState playerState;
    struct AIPlayer *aiPlayer;      // if non-null, then player has a computer AI Player
    udword autoLaunch;
    uword playerIndex;
    ubyte sensorLevel;
    ubyte bounty;                   //range from 0 to 100
    real32 timeMoShipAttacked;
    sdword totalships;                   // total ships for player
    sdword shiptotals[TOTAL_NUM_SHIPS];  // totals for each type of ship
    sdword classtotals[NUM_CLASSES];
    PlayerResearchInfo researchinfo;    // research information for player
    uword Allies;                       // bitmask of players that i am allied with
    uword AllianceProposals;
    udword AllianceProposalsTimeout;    // timeout counter for proposals to expire!
    sdword initialShipCost;				// total ship cost at game start
} Player;
*/