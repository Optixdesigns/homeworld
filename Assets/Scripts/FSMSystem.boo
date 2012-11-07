import System
import System.Collections
import System.Collections.Generic
import UnityEngine


/**
A Finite State Machine System based on Chapter 3.1 of Game Programming Gems 1 by Eric Dybsand
 
Written by Roberto Cezar Bianchini, July 2010
 
 
How to use:
	1. Place the labels for the transitions and the states of the Finite State System
	    in the corresponding enums.
 
	2. Write new class(es) inheriting from FSMState and fill each one with pairs (transition-state).
	    These pairs represent the state S2 the FSMSystem should be if while being on state S1, a
	    transition T is fired and state S1 has a transition from it to S2. Remember this is a Deterministic FSM. 
	    You can't have one transition leading to two different states.
 
	   Method Reason is used to determine which transition should be fired.
	   You can write the code to fire transitions in another place, and leave this method empty if you
	   feel it's more appropriate to your project.
 
	   Method Act has the code to perform the actions the NPC is supposed do if it's on this state.
	   You can write the code for the actions in another place, and leave this method empty if you
	   feel it's more appropriate to your project.
 
	3. Create an instance of FSMSystem class and add the states to it.
 
	4. Call Reason and Act (or whichever methods you have for firing transitions and making the NPCs
	     behave in your game) from your Update or FixedUpdate methods.
 
	Asynchronous transitions from Unity Engine, like OnTriggerEnter, SendMessage, can also be used, 
	just call the Method PerformTransition from your FSMSystem instance with the correct Transition 
	when the event occurs.
 
 
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE 
AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
/*

enum Transition:	
	NullTransition = 0	# Use this transition to represent a non-existing transition in your system


enum StateID:
	NullStateID = 0	# Use this ID to represent a non-existing State in your system	
*/
/*
abstract class FSMState:

	protected map as Dictionary[of Transition, StateID] = Dictionary[of Transition, StateID]()
	#protected stateID as StateID
	protected transition as T1ransition
	protected entity as object

	virtual public ID:
		get:
			raise ArgumentException('State ID not specified in child class')

	def AddTransition(trans as T1ransition, id as StateID):
		// Check if anyone of the args is invalid
		if trans == Transition.NullTransition:
			Debug.LogError('FSMState ERROR: NullTransition is not allowed for a real transition')
			return
		
		if id == StateID.NullStateID:
			Debug.LogError('FSMState ERROR: NullStateID is not allowed for a real ID')
			return
		
		// Since this is a Deterministic FSM,
		// check if the current transition was already inside the map
		if map.ContainsKey(trans):
			Debug.LogError((((('FSMState ERROR: State ' + ID.ToString()) + ' already has transition ') + trans.ToString()) + 'Impossible to assign to another state'))
			return
		
		map.Add(trans, id)

	def DeleteTransition(trans as T1ransition):
		// Check for NullTransition
		if trans == Transition.NullTransition:
			Debug.LogError('FSMState ERROR: NullTransition is not allowed')
			return
		
		// Check if the pair is inside the map before deleting
		if map.ContainsKey(trans):
			map.Remove(trans)
			return
		Debug.LogError((((("FSMState ERROR: Transition " + trans.ToString()) + " passed to ") + ID.ToString()) + " was not on the state's transition list"))

	def GetOutputState(trans as T1ransition):
		// Check if the map has this transition
		if map.ContainsKey(trans):
			return map[trans]
		
		return StateID.NullStateID
	public virtual def Enter():
		pass

	public virtual def Execute():
		pass

	public virtual def Exit():
		pass

	public def Update():
		if GlobalState is not null:
			GlobalState.Execute()
		if CurrentState is not null:
			CurrentState.Execute()
*/

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
		


/*
class FSMSystem:

	// The only way one can change the state of the FSM is by performing a transition
	// Don't change the CurrentState directly
	[Property(CurrentStateID)]
	private currentStateID as StateID	

	private currentState as FSMState
	public CurrentState as FSMState: 
		get:
			return self.currentState

	private states as List[of FSMState]
	public States as List[of FSMState]: 
		get:
			return self.states


	def constructor():
		self.states = List[of FSMState]()

	public def AddState(s as FSMState):
		// Check for Null reference before deleting
		if s is null:
			Debug.LogError('FSM ERROR: Null reference is not allowed')
		
		// First State inserted is also the Initial state,
		// the state the machine is in when the simulation begins

		if len(self.states) == 0:
			self.states.Add(s)
			self.currentState = s
			self.currentStateID = s.ID
			return
		#Debug.Log(states)
		// Add the state to the List if it's not inside it
		for state as FSMState in self.states:
			if state.ID == s.ID:
				Debug.LogError((('FSM ERROR: Impossible to add state ' + s.ID.ToString()) + ' because state has already been added'))
				return
		
		self.states.Add(s)
	
	public def DeleteState(id as StateID):
		// Check for NullState before deleting
		if id == StateID.NullStateID:
			Debug.LogError('FSM ERROR: NullStateID is not allowed for a real state')
			return
		
		// Search the List and delete the state if it's inside it
		for state as FSMState in self.states:
			if state.ID == id:
				self.states.Remove(state)
				return
		
		Debug.LogError((('FSM ERROR: Impossible to delete state ' + id.ToString()) + '. It was not on the list of states'))

	public def PerformTransition(trans as T1ransition):
		// Check for NullTransition before changing the current state
		if trans == Transition.NullTransition:
			Debug.LogError('FSM ERROR: NullTransition is not allowed for a real transition')
			return
		
		// Check if the currentState has the transition passed as argument
		id as StateID = self.currentState.GetOutputState(trans)
		if id == StateID.NullStateID:
			Debug.LogError((((('FSM ERROR: State ' + currentStateID.ToString()) + ' does not have a target state ') + ' for transition ') + trans.ToString()))
			return
		
		// Update the currentStateID and currentState		
		self.currentStateID = id
		for state as FSMState in self.states:
			if state.ID == currentStateID:
				// Do the post processing of the state before setting the new one
				self.currentState.DoBeforeLeaving()
				
				self.currentState = state
				
				// Reset the state to its desired condition before it can reason or act
				self.currentState.DoBeforeEntering()
				break 
*/
