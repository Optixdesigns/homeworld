using UnityEngine;
using System.Collections;

//All states should use the Serializable attribute if you want them to be visible in the inspector
[System.Serializable]
public class StateGamePlay : FSMState<UnitAI, UnitAI.States>
{
	public UnitAI.States winState = UnitAI.States.GameOverWinner;
	public UnitAI.States loseState = UnitAI.States.GameOverLoser;
	
	
	public override UnitAI.States StateID {
		get {
			return UnitAI.States.GamePlay;
		}
	}

	public override void Enter ()
	{	
		Debug.Log("Game Started - FIGHT!!");
		
		// Example of using events to affect state
		//entity.player.InstaWin += HandleInstaWin;
		
		//Example of manipulating state via direct access to the game domain
		//entity.player.ResetHealth();
		//entity.gui.ShowHealth = true;
		
		//Example of manipulating state via proxy call. 
		//This is considered better practice in some circles as it's easier to update/change - especially if other states are going to use the same functionality
		//entity.EnablePlayer(true);
	}


	public override void Execute ()
	{
		//entity.gui.UpdateHealth(entity.player.health);
		
		//Example of polling values to affect state logic
		//if(entity.player.health < 0)
		//{
		//	entity.ChangeState(loseState);
		//}
	}

	public override void Exit ()
	{
		//entity.gui.ShowHealth = false;
		//entity.EnablePlayer(false);
	}

	void HandleInstaWin (object sender, System.EventArgs e)
	{
		entity.ChangeState(winState);
	}
	
}

