import UnityEngine
import System.Collections


//All states should use the Serializable attribute if you want them to be visible in the inspector
[System.Serializable]
public class AIStateAttack(FSMState[of UnitAI, UnitAI.States]):

	//By referencing the next state as a variable visible in the inspector, it makes it very easy to modify the state changing logic
	//public nextState as UnitAI.States = UnitAI.States.GamePlay
	
	//Because propertie are now visible in the inspector, we can easily change state behaviours
	public delay as single = 1

	
	//FSM needs to function to keep track of the different states
	public override StateID as UnitAI.States:
		get:
			return UnitAI.States.Attack

	
	public override def Enter():
		
		Debug.Log(string.Format('Game will start in {0} seconds', delay))
		
		//You can reference the owner class via "entity". In this case Main.
		//entity.EnablePlayer(false);
		
		//entity.ChangeState(nextState, delay)

	
	public override def Execute():
		pass
		

	
	public override def Exit():
		pass
		
	
	

