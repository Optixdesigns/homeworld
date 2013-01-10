import UnityEngine
import System.Collections.Generic


[CustomEditor(typeof(AIBehaviours))]
public class AIBehavioursInspector(Editor):

    // The main foldout state
    private static statesToggle as Dictionary[of AIState, bool] = Dictionary[of AIState, bool]()

    public def OnEnable():
        pass

    public override def OnInspectorGUI():
        script = (target cast AIBehaviours)
        
        PGEditorUtils.LookLikeControls()
        EditorGUI.indentLevel = 1
        
        // Get all states for this FSM
        _statesPopupList as List[of string] = List[of string]()
        for i in range(0, script.states.Count):
            state = script.states[i]
            _statesPopupList.Add(state.GetType().ToString())
            if script.initialState is state:
                script.initialStateIndex = i
        
        // Render initial state popup
        script.initialStateIndex = EditorGUILayout.Popup('Initial State:', script.initialStateIndex, _statesPopupList.ToArray())
        script.initialState = script.states[script.initialStateIndex]
        
        // Render all state classes
        for state in script.states:
            if not state in statesToggle:
                statesToggle[state] = false

            EditorGUI.indentLevel = 0
            self.statesToggle[state] = EditorGUILayout.Foldout(self.statesToggle[state], state.GetType().ToString())

            if statesToggle[state]:
                EditorGUI.indentLevel = 2
                state.OnInspectorGUI()
        
        GUILayout.Space(4)
        
        // Flag Unity to save the changes to to the prefab to disk
        if GUI.changed:
            EditorUtility.SetDirty(target)
