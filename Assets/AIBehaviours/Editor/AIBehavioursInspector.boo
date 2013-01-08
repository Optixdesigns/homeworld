import UnityEngine

[CustomEditor(typeof(AIBehaviours))]
public class AIBehavioursInspector(Editor):

    // The main foldout state
    public expandEffects = true

    public def OnEnable():
        #types = System.Reflection.Assembly.GetExecutingAssembly().GetTypes()
        types = System.Reflection.Assembly.GetCallingAssembly().GetTypes()
        for type in types:
            Debug.Log(type)
        #Debug.Log(types)
        #possible = for type in types where type.IsSubclassOf(typeof(AIState))
        #possible = for type in types where type.IsSubclassOf(typeof(AIState))
        #Debug.Log("y")

    public override def OnInspectorGUI():
        script = (target cast AIBehaviours)
        
        PGEditorUtils.LookLikeControls()
        EditorGUI.indentLevel = 1
        
        #self.target = PGEditorUtils.SerializedObjFoldOutList[of HitEffectGUIBacker]('EffectOnTargets   (May be inherited)', script._effectsOnTarget, self.expandEffects, script._editorListItemStates, true)
        #script.states = PGEditorUtils.ObjectField[of AIState]("State", script.states)
        
        GUILayout.Space(4)
        #script.debugLevel = (EditorGUILayout.EnumPopup('Debug Level', (script.debugLevel cast System.Enum)) cast DEBUG_LEVELS)
        
        // Flag Unity to save the changes to to the prefab to disk
        if GUI.changed:
            EditorUtility.SetDirty(target)

