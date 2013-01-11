using UnityEngine;
using System.Collections;

//All states should use the Serializable attribute if you want them to be visible in the inspector
[System.Serializable]
public class StateGameOverWinner : FSMState<UnitAI, UnitAI.States>
{
	public UnitAI.States replayState = UnitAI.States.GamePlay;
	
	public override UnitAI.States StateID {
		get {
			return UnitAI.States.GameOverWinner;
		}
	}

	public override void Enter ()
	{
		Debug.Log("VICTORY!");
		
		//entity.gui.ShowGameOver(true, new GUIManager.Callback(HandleTryAgain));
	}

	public override void Execute ()
	{
		
	}

	public override void Exit ()
	{
		
	}
	
	private void HandleTryAgain()
	{
		entity.ChangeState(replayState);
	}
}

