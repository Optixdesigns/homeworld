using UnityEngine;
using System.Collections;

//All states should use the Serializable attribute if you want them to be visible in the inspector
[System.Serializable]
public class StateGameOverLoser : FSMState<UnitAI, UnitAI.States>
{
	public UnitAI.States replayState = UnitAI.States.GamePlay;
	
	public override UnitAI.States StateID {
		get {
			return UnitAI.States.GameOverLoser;
		}
	}

	public override void Enter ()
	{
		Debug.Log("Game Over! Insert Coin to continue");
		
		//Using a call back delegate to know when another part of the system has fired. 
		//This is an example of asynchronous state behaviour
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

