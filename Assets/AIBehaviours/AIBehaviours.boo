#ifdef UNITY_EDITOR:
import System.Collections
import System.Collections.Generic
import UnityEngine
import UnityEditor
#ifdef not UNITY_EDITOR:
#    import UnityEngine


enum AIStateID:
    NullStateID = 0 // Use this ID to represent a non-existing State in your system
    Idle = 1
    Move = 2
    Attack = 3  


[AddComponentMenu('Neworld/AIBehaviours')]
public class AIBehaviours(MonoBehaviour):
    /// Is this AI active (Read Only)?
    #public isActive as bool
    /// This is the state the AI is in once the game is playing.
    public initialState as AIState
    public initialStateIndex as int = 0
    /// This is the state the AI is currently in (Read Only).
    public currentState as AIState
    /// An array of all the states that belong to this AI.
    #public states as (AIState) = array(AIState, 0)
    #[SerializeField]
    public states as List[of AIState] = List[of AIState]()
    // Keeps the state of each individual foldout item during the editor session
    #public _editorListItemStates as Dictionary[of object, bool] = Dictionary[of object, bool]()
    /// Holds the total state count
    public stateCount as int:
        get:
            return states.Count

    /// Holds reference to the "States" gameobject
    #public statesGameObject as GameObject = null
    #public _editorListItemStates as Dictionary[of object, bool] = Dictionary[of object, bool]()

    #public _editorPopupListStates as Dictionary[of object, bool] = Dictionary[of object, bool]()

    #public _statesPopupList as List[of string] = List[of string]()
    /*
        Callables
    */
    #public callable StateChangedDelegate(newState as AIState, previousState as AIState)
    #public onStateChanged as StateChangedDelegate = null
    #public def OnEnable():

        #if (m_Instances == null)

        #self.states = List[of AIState]()

 

        #hideFlags = HideFlags.HideAndDontSave;

    public def Start():
        if not currentState and initialState:
            currentState = initialState

    public def Update():     
        // If the state remained the same, do the action
        #Debug.Log(currentState)
        if currentState:
            if currentState.HandleReason(self):
                currentState.HandleAction(self)

    public def GetAllStates() as List[of AIState]:
        return states

    public def AddState(state):
        if states.Count == 0:
            states.Add(state)
            currentState = state
            #currentStateID = s.ID
            return
 
        states.Add(state)

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
    
    public def OnGUI():
        Debug.Log(states.Count)
        for state in self.states:

            state.OnInspectorGUI()

    #def OnDrawGizmosSelected():
        #if currentState is not null:
            #currentState.DrawGizmosSelected(self)

#BehaviourStates = []

#[System.Serializable]
[System.Serializable]
public abstract class AIState(ScriptableObject):
#public abstract class AIState(MonoBehaviour):
    [SerializeField]
    public isEnabled as bool = true

    #public name as string

    #public def constructor():
        #BehaviourStates.Add(self)

    #public def OnEnable():
        #hideFlags = HideFlags.HideAndDontSave

    #[SerializeField]
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
        #DrawStateInspectorGUI(m_State)

    public abstract def DrawStateInspectorGUI(m_State as SerializedObject):
        pass

    /*
    public def DrawInspectorEditor(fsm as AIBehaviours):
        m_Object as SerializedObject = SerializedObject(self)
        #bool oldEnabled = GUI.enabled
        #bool drawEnabled = DrawIsEnabled(m_Object)

        GUI.enabled = true
        #GUILayout.Label('test')

        #AIBehavioursTriggersGUI.Draw(self, fsm)
        #EditorGUILayout.Separator()

        DrawStateInspectorEditor(m_Object, fsm)
        EditorGUILayout.Separator()

        m_Object.ApplyModifiedProperties()
    */


#[System.Serializable]
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

