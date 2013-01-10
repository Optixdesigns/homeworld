#ifdef UNITY_EDITOR:
import System.Collections
import System.Collections.Generic
import UnityEngine
import UnityEditor
#ifdef not UNITY_EDITOR:
#    import UnityEngine

[AddComponentMenu('Neworld/AIBehaviours')]
public class AIBehaviours(MonoBehaviour):
    /// Tranform of this guy
    /// This is the state the AI is in once the game is playing.
    public initialState as AIState
    // Index for the editor
    public _initialStateIndex as int = 0
    /// This is the state the AI is currently in (Read Only).
    private _currentState as AIState
    public currentState as AIState:
        get:
            if self._currentState:
                return self._currentState
            elif self.initialState:
                return self.initialState
        set:
            self._currentState = value

    // Previous state of this AI
    public previousState as AIState
    
    /// An array of all the states that belong to this AI.
    public states as List[of AIState] = List[of AIState]()

    /// Holds the total state count
    public stateCount as int:
        get:
            return states.Count

    /// Keeps the state of each individual foldout item during the editor session
    public _editorStatesFoldout as Dictionary[of AIState, bool] = Dictionary[of AIState, bool]()

    public def Start():
        if not currentState and initialState:
            currentState = initialState

    public def Update():     
        // If the state remained the same, do the action
        if self.currentState.HandleReason(self):
            self.currentState.HandleAction(self)

    public def GetAllStates() as List[of AIState]:
        return states

    public def AddState(s):
        
        if s == null:
            return
        #Debug.Log(s.isEnabled)
        // First state is also the initial state
        if not self.initialState:
            self.states.Add(s)
            self.initialState = s
            return
        
        // Check if its already in the list
        for state in self.states:
            #Debug.Log(state)
            if state.GetType().ToString() == s.GetType().ToString():
                Debug.LogError("AIBehaviours ERROR: Impossible to add state " + state.stateID + " because state has already been added")
                return

        self.states.Add(s)

    public def ReplaceAllStates(newStates as List[of AIState]):
        #Debug.Log(newStates[0])
        states = newStates
    /*
    public def ChangeActiveStateByName(stateName as string):
        #state as AIState
        for state as AIState in states:
            if state.name.Equals(stateName):
                ChangeActiveState(state)
                return
    */
    public def ChangeActiveStateByIndex(index as int):
        ChangeActiveState(states[index])

    public def ChangeActiveState(newState as AIState):
        #previousState as AIState = currentState

        if currentState is not null:
            currentState.EndState(self)
        
        currentState = newState
        
        if currentState is not null:
            currentState.InitState(self)

    #def OnDrawGizmosSelected():
        #if currentState is not null:
            #currentState.DrawGizmosSelected(self)

#BehaviourStates = []

#[System.Serializable]
#[System.Serializable]
public abstract class AIState(ScriptableObject):
#public abstract class AIState(MonoBehaviour):
    [SerializeField]
    public stateID as string:
        get:
            return self.GetType().ToString()

    [SerializeField]
    public isEnabled as bool = true

    public triggers as (AITrigger) = array(AITrigger, 0)

    def GetAllTriggers() as (AITrigger):
        return triggers

    def ReplaceAllTriggers(newTriggers as (AITrigger)):
        triggers = newTriggers
    
    /*
        State methods
    */
    protected abstract def Init(fsm as AIBehaviours):
        pass

    protected abstract def StateEnded(fsm as AIBehaviours):
        pass

    protected abstract def Reason(fsm as AIBehaviours) as bool:
        pass

    protected abstract def Action(fsm as AIBehaviours):
        pass

    public abstract def DrawGizmosSelected(fsm as AIBehaviours):
        pass

    public def InitState(fsm as AIBehaviours):        
        #InitTriggers()
        Init(fsm)
    
    public def EndState(fsm as AIBehaviours):
        StateEnded(fsm)

    public def HandleReason(fsm as AIBehaviours):
        if CheckTriggers(fsm):
            return false

        return Reason(fsm)

    public def HandleAction(fsm as AIBehaviours):
        Action(fsm)

    protected def CheckTriggers(fsm as AIBehaviours) as bool:
        for trigger as AITrigger in triggers:
            if trigger.HandleEvaluate(fsm):
                return true

        return false

    #protected abstract def OnDrawGizmosSelected():
        #pass

    /*
        Editor methods
    */
    public def OnInspectorGUI():
        m_State as SerializedObject = SerializedObject(self)
        m_property = m_State.FindProperty("isEnabled")
        EditorGUILayout.PropertyField(m_property)
        
        self.DrawStateInspectorGUI(m_State)
        
        m_State.ApplyModifiedProperties()

    public abstract def DrawStateInspectorGUI(m_State as SerializedObject):
        pass


[System.Serializable]
public abstract class AITrigger(MonoBehaviour):
    public transitionState as AIState
    public name as string = ""

    public def HandleEvaluate(fsm as AIBehaviours) as bool:
        if not self.enabled:
            return false

        return Evaluate(fsm)

    protected abstract def Init(fsm as AIBehaviours):
        pass

    protected abstract def Evaluate(fsm as AIBehaviours) as bool:
        pass

