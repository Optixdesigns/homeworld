import System
import System.Collections
import System.Collections.Generic
import UnityEngine
import UnityEditor


[CustomEditor(typeof(AIBehaviours))]
#[CanEditMultipleObjects]
public class AIBehavioursEditor(Editor):
    
    private fsm as AIBehaviours
    #private states as (AIState)
    private SO as SerializedObject
    /// Holds reference to the "States" gameobject
    #private statesGameObject as GameObject
    private statesGameObject as GameObject
    private statesGameObjectProp as SerializedProperty
    private initialStateProp as SerializedProperty
    private isActiveProp as SerializedProperty

    private statesProp as SerializedProperty

    /// Toggle states for each state foldout
    statesToggle as Dictionary[of int, bool] = Dictionary[of int, bool]()
    
    foldoutGUIStyle as GUIStyle = GUIStyle(EditorStyles.foldout)
    #m_InitialState as SerializedProperty

    def OnEnable():
        states as (AIState)

        SO = SerializedObject(target)
        isActiveProp = SO.FindProperty('isActive')
        statesProp = SO.FindProperty('states')
        initialStateProp = SO.FindProperty('initialState')
        statesGameObjectProp = SO.FindProperty('statesGameObject')
        
        fsm = target
        transform = fsm.transform

        InitStates()
        
        for i in range(0, fsm.stateCount):
            statesToggle[i] = false

    def OnInspectorGUI():
        states = fsm.GetAllStates()
        SO.Update()
        
        #isActiveProp.boolValue = EditorGUILayout.Toggle(isActiveProp.name.ToString(), isActiveProp.boolValue)

        for i in range(0, states.Length):
            GUILayout.BeginHorizontal(GUILayout.Height(20))
            #guiWidths = 90
            
            #foldoutGUIStyle.normal.textColor = Color.green if not states[i].isEnabled else Color.grey
            foldoutGUIStyle.normal.textColor = Color.black
            if states[i] is fsm.currentState:
               foldoutGUIStyle.normal.textColor = Color.green 

            statesToggle[i] = EditorGUILayout.Foldout(statesToggle[i], states[i].name, foldoutGUIStyle)
            if EditorGUILayout.Toggle(states[i].isEnabled, GUILayout.Height(20)) != states[i].isEnabled:
                states[i].isEnabled = (not states[i].isEnabled)
            
            GUILayout.Space(20)
            GUILayout.EndHorizontal()

            /// Render state if toggled
            if statesToggle[i]:
                GUILayout.BeginHorizontal()
                states[i].DrawInspectorEditor(fsm)
                GUILayout.EndHorizontal()

        DrawInitialStatePopup()

        if GUI.changed:
            EditorUtility.SetDirty(target)

        SO.ApplyModifiedProperties()

    private def InitStates():
        if statesGameObjectProp.objectReferenceValue is null:
            statesGameObject = GameObject('AIStates')
            statesGameObjectProp.objectReferenceValue = statesGameObject
            
            statesGameObject.transform.parent = fsm.transform
            statesGameObject.transform.localPosition = Vector3.zero
            statesGameObject.transform.localRotation = Quaternion.identity
            statesGameObject.transform.localScale = Vector3.one
            SO.ApplyModifiedProperties()

            InitNewStates()
            Debug.Log("new")
        else:    
            statesGameObject as GameObject = statesGameObjectProp.objectReferenceValue
            Debug.Log("Existing")

        states = fsm.GetAllStates()

    private def InitNewStates():
        statesDictionary as Dictionary[of string, Type] = Dictionary[of string, Type]()
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

        fsm.ReplaceAllStates(statesList.ToArray())
        #states = fsm.GetAllStates()
    /*
    private def GetExistingStates():
        states as (AIState) = fsm.GetAllStates()
        
        for state as AIState in states:
            if string.IsNullOrEmpty(state.name):
                sObject = SerializedObject(state)
                mProp as SerializedProperty = sObject.FindProperty('name')
                stateTypeName as string = state.GetType().ToString()
                #state as AIState = fsm.initialState
                #sObject = SerializedObject(state)
                
                #stateTypeName as string = state.GetType().ToString()
                #state.name = stateTypeName
                
                mProp.stringValue = stateTypeName
                sObject.ApplyModifiedProperties()
    */

    private def DrawInitialStatePopup():
        statesPopupList as List[of string] = List[of string]()
        states as (AIState) = fsm.GetAllStates()

        for i in range(0, states.Length):
            statesPopupList.Add(states[i].name)
            if initialStateProp.objectReferenceValue is states[i]:
                indexPopup = i

        indexPopup = EditorGUILayout.Popup('Initial State:', indexPopup, statesPopupList.ToArray())
        initialStateProp.objectReferenceValue = states[indexPopup] as AIState  # Maybe only on mutation of the value?

    /*
    private def InitNewTriggers():
        triggersDictionary as Dictionary[of string, Type] = Dictionary[of string, Type]()
        triggersList as List[of AITrigger] = List[of AITrigger]()
   
        // Setup a dictionary of the default triggers
        triggersDictionary['Test'] = typeof(TestTrigger)
        
        for triggerName as string in triggersDictionary.Keys:

            triggerClassName as string = triggersDictionary[triggerName].ToString()
            
            try:
                aiTrigger as AITrigger = (fsm.statesGameObject.AddComponent(triggerClassName) as AITrigger)

                sObject = SerializedObject(aiTrigger)
                mProp as SerializedProperty = sObject.FindProperty('name')
                
                mProp.stringValue = triggerName
                sObject.ApplyModifiedProperties()
                
                triggersList.Add(aiTrigger)
            except :
                Debug.LogError((((('Type "' + triggerClassName) + '" does not exist.  You must have a class named "') + triggerClassName) + '" that derives from "AITrigger".'))
                inittedSuccessfully = false 
        
        state.ReplaceAllTriggers(triggersList.ToArray())
    */

