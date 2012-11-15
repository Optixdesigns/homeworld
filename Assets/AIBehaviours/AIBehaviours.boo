#ifdef UNITY_EDITOR:
import UnityEditor
import UnityEngine
#ifdef not UNITY_EDITOR:
#    import UnityEngine


[AddComponentMenu('Neworld/AIBehaviours')]
public class AIBehaviours(MonoBehaviour):

    /// This is the state the AI is in once the game is playing.
    public initialState as AIState
    /// This is the state the AI is currently in (Read Only).
    public currentState as AIState
    /// An array of all the states that belong to this AI.
    public states as (AIState) = array(AIState, 0)
    /// Holds the total state count
    public stateCount as int:
        get:
            return states.Length
    /// Holds reference to the "States" gameobject
    public statesGameObject as GameObject = null

    /*
        Callables
    */
    public callable StateChangedDelegate(newState as AIState, previousState as AIState)
    public onStateChanged as StateChangedDelegate = null

    def Awake():
        pass

    def GetAllStates() as (AIState):
        return states

    def ReplaceAllStates(newStates as (AIState)):
        states = newStates
    /*
    public def ChangeActiveStateByName(stateName as string):
        for state as AIState in states:
            if state.name.Equals(stateName):
                ChangeActiveState(state)
                return
    */
    public def ChangeActiveStateByIndex(index as int):
        ChangeActiveState(states[index])

    public def ChangeActiveState(newState as AIState):
        previousState as AIState = currentState
        
        if currentState is not null:
            currentState.EndState(self)
        
        currentState = newState
        
        if currentState is not null:
            currentState.InitState(self)
        onStateChanged(newState, previousState)
        

#[System.Serializable]
public abstract class AIState(MonoBehaviour):
    public isEnabled as bool = true
    public name as string = ""

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

    public def InitState(fsm as AIBehaviours):        
        #InitTriggers()
        Init(fsm)
    
    public def EndState(fsm as AIBehaviours):
        StateEnded(fsm)

    /*
        Editor methods
    */
    protected abstract def DrawStateInspectorEditor(m_Object as SerializedObject, fsm as AIBehaviours):
        pass

    public def DrawInspectorEditor(fsm as AIBehaviours):
        m_Object as SerializedObject = SerializedObject(self)
        #bool oldEnabled = GUI.enabled
        #bool drawEnabled = DrawIsEnabled(m_Object)

        GUI.enabled = true
        GUILayout.Label('test')

        AIBehavioursTriggersGUI.Draw(self, fsm)
        EditorGUILayout.Separator()

        #DrawProperties(m_Object, stateMachine)
        EditorGUILayout.Separator()

        m_Object.ApplyModifiedProperties()


#[System.Serializable]
public abstract class AITrigger(MonoBehaviour):
    public transitionState as AIState
    public name as string = ""

    protected abstract def Evaluate(fsm as AIBehaviours)  as bool:
        pass
