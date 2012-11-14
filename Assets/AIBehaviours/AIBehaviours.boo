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

    def Awake():
        pass

    def GetAllStates() as (AIState):
        return states

    def ReplaceAllStates(newStates as (AIState)):
        states = newStates


#[System.Serializable]
public abstract class AIState(MonoBehaviour):
    public isEnabled as bool = true
    public name as string = ""

    #[SerializeField]
    public triggers as (AITrigger) = array(AITrigger, 0)
    #public triggers as List[of AITrigger]

    public virtual def Reason(fsm as AIBehaviours):
        pass

    public virtual def Action(fsm as AIBehaviours):
        pass

    protected abstract def DrawStateInspectorEditor(m_Object as SerializedObject, fsm as AIBehaviours):
        pass

    public def DrawInspectorEditor(fsm as AIBehaviours):
        m_Object as SerializedObject = SerializedObject(self)
        #bool oldEnabled = GUI.enabled
        #bool drawEnabled = DrawIsEnabled(m_Object)

        GUI.enabled = true
        GUILayout.Label('test')

        #AIBehaviorsTriggersGUI.Draw(m_Object, stateMachine)
        EditorGUILayout.Separator()

        #AIBehaviorsAnimationEditorGUI.DrawAnimationFields(m_Object)
        EditorGUILayout.Separator()

        #DrawMovementOptions(m_Object)
        EditorGUILayout.Separator()

        #DrawCooldownProperties(m_Object, stateMachine)
        EditorGUILayout.Separator()

        #DrawAudioProperties(m_Object)
        EditorGUILayout.Separator()

        #DrawStateInspectorEditor(m_Object, fsm)

        m_Object.ApplyModifiedProperties()

        #GUI.enabled = oldEnabled;


#[System.Serializable]
public abstract class AITrigger(MonoBehaviour):
    public virtual def Evaluate(fsm as AIBehaviours):
        pass
