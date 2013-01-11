import UnityEngine
import System.Collections

[System.Serializable]
public class UnitAI(MonoBehaviour):

	
	//Declare enum for each of our states. This makes it easier to specify states in the inpsector
	public enum States:
		Init
		Idle
		Move
		Attack

	//Refernce to a regular game object, in this case our not so heroic main player
	//public Player player;
	//public GUIManager gui;
	[SerializeField]
	public initialState as FSMState[of UnitAI, UnitAI.States]
	
	//By making these public properties, and using [System.Serializable] in the state classes, these will now appear in the inspector
	public stateInit = AIStateInit()
	public stateIdle = AIStateIdle()
	public stateMove = AIStateMove()
	public stateAttack = AIStateAttack()
	
	//The referecne to our state machine
	private FSM as FiniteStateMachine[of UnitAI, UnitAI.States]

	private def Start():
		//Initialise the state machine
		FSM = FiniteStateMachine[of UnitAI, UnitAI.States](self)
		FSM.RegisterState(stateInit)
		FSM.RegisterState(stateIdle)
		FSM.RegisterState(stateMove)
		FSM.RegisterState(stateAttack)
		
		//Kick things off
		ChangeState(stateInit.StateID)

	
	private def Update():
		//Must remember to update our state machine
		FSM.Update()

	
	//Some examples of utility functions for changing state.
	//Its up to you to decide how you actually change you state
	public def ChangeState(newState as States):
		FSM.ChangeState(newState)

	
	public def ChangeState(newState as States, delay as single):
		StartCoroutine(ChangeStateWithDelay(newState, delay))

	
	private def ChangeStateWithDelay(newState as States, delay as single) as IEnumerator:
		yield WaitForSeconds(delay)
		ChangeState(newState)

	
	
	public def ShowGameOver():
		pass
		

