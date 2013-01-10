import UnityEngine
import System.Collections.Generic


[CustomEditor(typeof(AIBehaviours))]
public class AIBehavioursInspector(Editor):

    private SO as SerializedObject
    private script as AIBehaviours
    private statesGameObjectProp as SerializedProperty

    public def Awake():
        script = (target cast AIBehaviours)
        SO = SerializedObject(target)

        statesGameObjectProp = SO.FindProperty('statesGameObject')
        #script = (AIBehaviours)target

        InitStates()
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
        SO._initialStateIndex = EditorGUILayout.Popup('Initial State:', SO._initialStateIndex, _statesPopupList.ToArray())
        SO.initialState = SO.states[SO._initialStateIndex]

        #m_property = serializedObject.FindProperty("states")
        #EditorGUILayout.PropertyField(m_property)

        // Render current state
        currentStateName = "None"
        if script.currentState:
            currentStateName = So.currentState.GetType().ToString()
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

    private def InitStates():
        if statesGameObjectProp.objectReferenceValue is null:
            statesGameObject = GameObject('AIStates')
            statesGameObjectProp.objectReferenceValue = statesGameObject
            
            statesGameObject.transform.parent = fsm.transform
            statesGameObject.transform.localPosition = Vector3.zero
            statesGameObject.transform.localRotation = Quaternion.identity
            statesGameObject.transform.localScale = Vector3.one
            script.ApplyModifiedProperties()

            InitNewStates()
            Debug.Log("new")
        else:    
            statesGameObject as GameObject = statesGameObjectProp.objectReferenceValue
            Debug.Log("Existing")

        states = script.GetAllStates()

    private def InitNewStates():
        statesDictionary as Dictionary[of string, AIState] = Dictionary[of string, AIState]()
        statesList as List[of AIState] = List[of AIState]()
        
        // Setup a dictionary of the default states
        statesDictionary['Idle'] = typeof(AIIdleState)
        statesDictionary['Move'] = typeof(AIMoveState)
        statesDictionary['Attack'] = typeof(AIAttackState)
        
        for stateName as string in statesDictionary.Keys:
            stateClassName as string = statesDictionary[stateName].ToString()
            
            try:
                aiState = (statesGameObject.AddComponent(stateClassName) as AIState)
                aiState.name = stateName
                
                statesList.Add(aiState)
            except :
                Debug.LogError((((('Type "' + stateClassName) + '" does not exist.  You must have a class named "') + stateClassName) + '" that derives from "AIState".'))
                inittedSuccessfully = false

        script.ReplaceAllStates(statesList)
        #states = fsm.GetAllStates()
