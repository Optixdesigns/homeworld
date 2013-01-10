import UnityEngine
import System.Collections.Generic


[CustomEditor(typeof(AIBehaviours))]
public class AIBehavioursInspector(Editor):

    private script as AIBehaviours

    public def Awake():
        script = (target cast AIBehaviours)
        #script = (AIBehaviours)target

        SetupStates()
        #unit = script.gameObject.GetComponent[of Unit]()
        //pass
        # TODO AUCCHHHH
        #Debug.Log(target.ToString())
        #unit = target.gameObject.GetComponent[of Unit]()
        #script.ReplaceAllStates(List[of AIState]())
        #unit.SetupFSM()

        #Debug.Log("ENABLLEEE")

    public override def OnInspectorGUI():
        #script = (target cast AIBehaviours)
        #m_Behaviour as SerializedObject = SerializedObject(self)
        
        PGEditorUtils.LookLikeControls()
        EditorGUI.indentLevel = 1
        
        // Get all states for this FSM
        _statesPopupList as List[of string] = List[of string]()
        
        for i in range(0, script.states.Count):
            state = script.states[i]
            #Debug.Log(state)
            _statesPopupList.Add(state.GetType().ToString())
            if script.initialState is state:
                script._initialStateIndex = i
        #Debug.Log(_statesPopupList.Count)
        // Render initial state popup
        script._initialStateIndex = EditorGUILayout.Popup('Initial State:', script._initialStateIndex, _statesPopupList.ToArray())
        script.initialState = script.states[script._initialStateIndex]

        #m_property = serializedObject.FindProperty("states")
        #EditorGUILayout.PropertyField(m_property)

        // Render current state
        currentStateName = "None"
        if script.currentState:
            currentStateName = script.currentState.GetType().ToString()
        EditorGUILayout.LabelField("Current State:", currentStateName)

        // Render all state classes
        for state in script.states:
            if not state in script._editorStatesFoldout:
                script._editorStatesFoldout[state] = false

            EditorGUI.indentLevel = 0
            script._editorStatesFoldout[state] = EditorGUILayout.Foldout(script._editorStatesFoldout[state], state.GetType().ToString())

            if script._editorStatesFoldout[state]:
                EditorGUI.indentLevel = 2
                state.OnInspectorGUI()

        GUILayout.Space(4)
        
        // Flag Unity to save the changes to to the prefab to disk
        if GUI.changed:
            EditorUtility.SetDirty(target)

    def SetupStates():
        #self.fsm = gameObject.GetComponent[of AIBehaviours]()
        #newlist as System.Collections.Generic.List[of AIState] = System.Collections.Generic.List[of AIState]()
        #self.fsm.ReplaceAllStates(newlist)

        /*
        idle as AIIdleState = AIIdleState()
        move as AIMoveState = AIMoveState()
        attack as AIAttackState = AIAttackState()
        */
        idle as AIIdleState = ScriptableObject.CreateInstance(typeof(AIIdleState))
        move as AIMoveState = ScriptableObject.CreateInstance(typeof(AIMoveState))
        attack as AIAttackState = ScriptableObject.CreateInstance(typeof(AIAttackState))
       
        script.AddState(idle)
        script.AddState(move)
        script.AddState(attack)
