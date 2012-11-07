import System
import System.Collections
import System.Collections.Generic
import UnityEngine


public class FSMState[of T1, T2]:

	protected entity as T1
	#private transitions as Dictionary[of U, FSMState[of T, T2]]
	#protected map as Dictionary[of Transition, StateID] = Dictionary[of Transition, StateID]()

	public virtual ID as T2:
		get:
			raise ArgumentException('State ID not specified in child class')

	public def RegisterState(entity as T1):
		self.entity = entity
    /*
	public def RegisterTransition(transId as T1ransition, stateId as StateID)):
		#transId as T1ransition, stateId as StateID)
		state.RegisterState(Owner)
		stateRef.Add(state.ID, state)
		return state

	public def UnregisterTransition(state as FSMState[of T, T2]):
		stateRef.Remove(state.ID)
	*/
	public virtual def Enter():
		pass

	public virtual def Execute():
		pass

	public virtual def Exit():
		pass


public class FSMSystem[of T1, T2]:

	private Owner as T1
	private CurrentState as FSMState[of T1, T2]
	private PreviousState as FSMState[of T1, T2]
	private GlobalState as FSMState[of T1, T2]

	#private stateref as Dictionary<U,FSMState<T,U>> stateRef;
	private stateRef as Dictionary[of T2, FSMState[of T1, T2]]
	
	public def Awake():
		CurrentState = null
		PreviousState = null
		GlobalState = null

	public def constructor(owner as T1):
		Owner = owner
		stateRef = Dictionary[of T2, FSMState[of T1, T2]]()
	
	public def Update():
		#Debug.Log(CurrentState)
		if GlobalState is not null:
			GlobalState.Execute()
		if CurrentState is not null:
			CurrentState.Execute()

	public def ChangeState(NewState as FSMState[of T1, T2]):
		PreviousState = CurrentState
		
		if CurrentState is not null:
			CurrentState.Exit()
		
		CurrentState = NewState
		
		if CurrentState is not null:
			CurrentState.Enter()

	public def RevertToPreviousState():
		if PreviousState is not null:
			ChangeState(PreviousState)
	
	//Changing state via enum
	public def ChangeState(stateID as T2):
		try:
			state as FSMState[of T1, T2] = stateRef[stateID]
			ChangeState(state)
		
		except converterGeneratedName1 as KeyNotFoundException:
			raise Exception('There is no State assiciated with that definition')

	public def RegisterState(state as FSMState[of T1, T2]) as FSMState[of T1, T2]:
		state.RegisterState(Owner)
		stateRef.Add(state.ID, state)
		return state

	
	public def UnregisterState(state as FSMState[of T1, T2]):
		stateRef.Remove(state.ID)
