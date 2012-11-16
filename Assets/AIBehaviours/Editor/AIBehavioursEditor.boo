import System
import System.Collections
import System.Collections.Generic
import UnityEngine
import UnityEditor


[CustomEditor(typeof(AIBehaviours))]
#[CanEditMultipleObjects]
public class AIBehavioursEditor(Editor):
    
    private fsm as AIBehaviours
    private states as (AIState)
    #private m_Object as SerializedObject
    /// Holds reference to the "States" gameobject
    #private statesGameObject as GameObject
    private statesGameObject as GameObject
    private statesGameObjectProp as SerializedProperty
    private initialStateProp as SerializedProperty
    private isActiveProp as SerializedProperty

    /// Toggle states for each state foldout
    statesToggle as Dictionary[of int, bool] = Dictionary[of int, bool]()
    
    #m_InitialState as SerializedProperty

    def OnEnable():
        #states as (AIState)
        isActiveProp = serializedObject.FindProperty('isActive')
        #Debug.Log(isActiveProp.name)
        
        #Debug.Log(target)
        #Debug.Log(targets)
        fsm = target
        transform = fsm.transform
        #m_Object = SerializedObject(target)
        #fsm = m_Object.targetObject as AIBehaviours
        
        
        InitStates()
        states = fsm.GetAllStates()
        Debug.Log(states.Length)
        #state as (AIIdleState) = statesGameObject.GetComponents(AIIdleState)
        #Debug.Log(state)


        #if initialStateProp.objectReferenceValue is null: // Get first state
            #initialStateProp.objectReferenceValue = states[0]
        #Debug.Log(statesGameObjectProp.objectReferenceValue)
        // Init states
        
        
        for i in range(0, fsm.stateCount):
            statesToggle[i] = false

        #fsm.initialState = states[0]
        #m_InitialState = m_Object.FindProperty('initialState')
        #m_InitialState.objectReferenceValue = states[0]
        #Debug.Log(states[0])
        #if not m_InitialState.objectReferenceValue:
        #m_InitialState.objectReferenceValue as AIState = states[0]
        #if initialStateProp.objectReferenceValue is null:
            #initialStateProp.objectReferenceValue = states[0]

    def OnInspectorGUI():
        states = fsm.GetAllStates()
        serializedObject.Update()
        
        isActiveProp.boolValue = EditorGUILayout.Toggle(isActiveProp.name.ToString(), isActiveProp.boolValue)


        for i in range(0, states.Length):
            GUILayout.BeginHorizontal(GUILayout.Height(20))
            #guiWidths = 90
            
            #GUILayout.Label(states[i].name, GUILayout.MaxWidth(guiWidths))
            statesToggle[i] = EditorGUILayout.Foldout(statesToggle[i], states[i].name)
            if EditorGUILayout.Toggle(states[i].isEnabled, GUILayout.Height(20)) != states[i].isEnabled:
                states[i].isEnabled = (not states[i].isEnabled)
            
            GUILayout.Space(20)
            GUILayout.EndHorizontal()

            /// Render state if toggled
            if statesToggle[i]:
                GUILayout.BeginHorizontal()
                states[i].DrawInspectorEditor(fsm)
                GUILayout.EndHorizontal()

        #DrawInitialStatePopup()

        serializedObject.ApplyModifiedProperties()

    #def OnInspectorUpdate():
        #Repaint()

    private def InitStates():
        #serializedObject.Update()
        statesGameObjectProp = serializedObject.FindProperty('statesGameObject')
        initialStateProp = serializedObject.FindProperty('initialState')
        #Debug.Log(statesGameObjectProp.objectReferenceValue)
    
        #m_Prop as SerializedProperty = SerializedObject.FindProperty('statesGameObject')
        #Debug.Log(statesGameObjectProp)
        if statesGameObjectProp.objectReferenceValue is null:
            statesGameObject = GameObject('AIStates')
            statesGameObjectProp.objectReferenceValue = statesGameObject
            
            statesGameObject.transform.parent = fsm.transform
            statesGameObject.transform.localPosition = Vector3.zero
            statesGameObject.transform.localRotation = Quaternion.identity
            statesGameObject.transform.localScale = Vector3.one
            #serializedObject.ApplyModifiedProperties()
            InitNewStates()
            Debug.Log("new")
        else:    
            statesGameObject = (statesGameObjectProp.objectReferenceValue as GameObject)
            #GetExistingStates()
            Debug.Log("Existing")

        #states = fsm.GetAllStates()
        #Debug.Log(states.Length)

        serializedObject.ApplyModifiedProperties()

        #Debug.Log(initialStateProp.objectReferenceValue)

    private def InitNewStates():
        statesDictionary as Dictionary[of string, Type] = Dictionary[of string, Type]()
        statesList as List[of AIState] = List[of AIState]()
        
        // Setup a dictionary of the default states
        statesDictionary['Idle'] = typeof(AIIdleState)
        statesDictionary['Move'] = typeof(AIMoveState)
        
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

    private def DrawInitialStatePopup():
        #m_InitialState as SerializedProperty = SerializedObject.FindProperty("initialState")
        #__state = initialStateProp.objectReferenceValue
        #__state = serializedObject.FindProperty("initialState")
        __state = serializedObject.FindProperty("initialState")
        

        statesList as List[of string] = List[of string]()
        states as (AIState) = fsm.GetAllStates()
        #Debug.Log(states.Length)
        for i in range(0, states.Length):
            if __state.name == states[i].name:
                indexPopup = i
            statesList.Add(states[i].name)
        
        indexPopup = EditorGUILayout.Popup('Initial State:', indexPopup, statesList.ToArray())
        #Debug.Log(initialStateProp.objectReferenceValue)
        initialStateProp.objectReferenceValue = states[indexPopup]

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

