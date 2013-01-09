import UnityEngine

[CustomEditor(typeof(AIBehaviours))]
public class AIBehavioursInspector(Editor):

    // The main foldout state
    public expandEffects = true
    #private script

    public def OnEnable():
        pass
        #script = (target cast AIBehaviours)
        #Debug.Log(script.states)
        #types = System.Reflection.Assembly.GetExecutingAssembly().GetTypes()
        #types = System.Reflection.Assembly.GetCallingAssembly().GetTypes()
        #for type in types:
            #Debug.Log(type)
        #Debug.Log(types)
        #possible = for type in types where type.IsSubclassOf(typeof(AIState))
        #possible = for type in types where type.IsSubclassOf(typeof(AIState))
        #Debug.Log("y")

    public override def OnInspectorGUI():
        script = (target cast AIBehaviours)
        
        PGEditorUtils.LookLikeControls()
        EditorGUI.indentLevel = 1
        

        #self.expandEffects = PGEditorUtils.SerializedObjFoldOutList[of AIState]('EffectOnTargets', script.states, self.expandEffects, script._editorListItemStates, true)
        #script.states = PGEditorUtils.ObjectField[of AIState]("State", script.states)
        /*
        i = 0
        for state in script.states:
            #Debug.Log(state)
            #script.states[i] = PGEditorUtils.ObjectField[of AIState]("State", script.states[i])
            PGEditorUtils.SerializedObjectFields[of AIState](state, true)
            
            i += 1
        */
        EditorGUI.indentLevel = 2
        for state in script.states:
            EditorGUILayout.LabelField("Time since start: ", 
            EditorApplication.timeSinceStartup.ToString());
            state.isEnabled = EditorGUILayout.Toggle("Enabled", state.isEnabled)
            state.OnInspectorGUI()
        
        GUILayout.Space(4)
        #script.debugLevel = (EditorGUILayout.EnumPopup('Debug Level', (script.debugLevel cast System.Enum)) cast DEBUG_LEVELS)
        
        // Flag Unity to save the changes to to the prefab to disk
        if GUI.changed:
            EditorUtility.SetDirty(target)

