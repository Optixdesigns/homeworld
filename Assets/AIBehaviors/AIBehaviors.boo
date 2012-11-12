import System
import System.IO
import System.Text.RegularExpressions
import UnityEngine
import System.Collections.Generic
import System.Globalization


#[AddComponentMenu('AIBehaviors')]
[System.Serializable]
public class AIBehaviors():

    #public AIStates as List[of AIState] = List[of AIState]()
    #public AITriggers as List[of AITrigger] = List[of AITrigger]()
    public states as AIState
    public triggers as List[of AITrigger]

    #public def Awake():
        #AIStates.Add(AIIdleState())
        #print AIStates

    #public def constructor():
        #Owner = owner
    #    stateRef = Dictionary[of T2, FSMState[of T1, T2]]()
    #public initialState
    #public healthScript
    #public def RegisterState(state as AIState]:
        #state.RegisterState(Owner)
        #stateRef.Add(state.ID, state)
        #return stat

[System.Serializable]
public class AIState(MonoBehaviour):

    public virtual def Reason(fsm as AIBehaviors):
        pass

    public virtual def Action(fsm as AIBehaviors):
        pass

[System.Serializable]
public class AITrigger:

    public virtual def Evaluate(fsm as AIBehaviors):
        pass