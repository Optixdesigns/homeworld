import System
import System.Collections
import System.Collections.Generic
import UnityEngine
import UnityEditor


[CustomEditor(typeof(AIBehaviours))]
public class AIBehavioursEditor(Editor):
    
    private fsm as AIBehaviours = null
    private m_Object as SerializedObject
    /// Holds reference to the "States" gameobject
    private statesGameObject as GameObject

    /// Toggle states for each state foldout
    toggle as Dictionary[of int, bool] = Dictionary[of int, bool]()
    
    m_InitialState as SerializedProperty

    def OnEnable():
        states as (AIState)

        m_Object = SerializedObject(target)
        fsm = (m_Object.targetObject as AIBehaviours)

        InitStates()
        states = fsm.GetAllStates()
        for i in range(0, fsm.stateCount):
            toggle[i] = false

        m_InitialState = m_Object.FindProperty('initialState')

    public override def OnInspectorGUI():
        m_Object.Update()

        states as (AIState) = fsm.GetAllStates()
        
        for i in range(0, fsm.stateCount):
            GUILayout.BeginHorizontal(GUILayout.Height(20))
            #guiWidths = 90
            
            #GUILayout.Label(states[i].name, GUILayout.MaxWidth(guiWidths))
            toggle[i] = EditorGUILayout.Foldout(toggle[i], states[i].name)
            if EditorGUILayout.Toggle(states[i].isEnabled, GUILayout.Height(20)) != states[i].isEnabled:
                states[i].isEnabled = (not states[i].isEnabled)
            
            GUILayout.Space(20)
            GUILayout.EndHorizontal()

            /// Render state if toggled
            if toggle[i]:
                GUILayout.BeginHorizontal()
                states[i].DrawInspectorEditor(fsm)
                GUILayout.EndHorizontal()

        DrawInitialStatePopup()

        m_Object.ApplyModifiedProperties()

    def OnInspectorUpdate():
        Repaint()

    private def InitStates():
        m_Prop as SerializedProperty = m_Object.FindProperty('statesGameObject')

        if m_Prop.objectReferenceValue is null:
            statesGameObject = GameObject('AIStates')
            m_Prop.objectReferenceValue = statesGameObject
            
            statesGameObject.transform.parent = fsm.transform
            statesGameObject.transform.localPosition = Vector3.zero
            statesGameObject.transform.localRotation = Quaternion.identity
            statesGameObject.transform.localScale = Vector3.one
            
            m_Object.ApplyModifiedProperties()
            InitNewStates()
        else:    
            statesGameObject = (m_Prop.objectReferenceValue as GameObject)
            GetExistingStates()   

    private def InitNewStates():
        statesDictionary as Dictionary[of string, Type] = Dictionary[of string, Type]()
        statesList as List[of AIState] = List[of AIState]()
        
        // Setup a dictionary of the default states
        statesDictionary['Idle'] = typeof(AIIdleState)
        statesDictionary['Move'] = typeof(AIMoveState)
        
        for stateName as string in statesDictionary.Keys:
            stateClassName as string = statesDictionary[stateName].ToString()
            
            try:
                baseState = (statesGameObject.AddComponent(stateClassName) as AIState)
                baseState.name = stateName
                
                statesList.Add(baseState)
            except :
                Debug.LogError((((('Type "' + stateClassName) + '" does not exist.  You must have a class named "') + stateClassName) + '" that derives from "AIState".'))
                inittedSuccessfully = false
        
        fsm.ReplaceAllStates(statesList.ToArray())

    private def GetExistingStates():
        states as (AIState) = fsm.GetAllStates()
        
        for state as AIState in states:
            if string.IsNullOrEmpty(state.name):
                sObject = SerializedObject(state)
                mProp as SerializedProperty = sObject.FindProperty('name')
                stateTypeName as string = state.GetType().ToString()
                
                mProp.stringValue = AIBehaviorsComponentInfoHelper.GetNameFromType(stateTypeName)
                sObject.ApplyModifiedProperties()

    private def DrawInitialStatePopup():
        #m_InitialState as SerializedProperty = m_Object.FindProperty('initialState')
        #state = (m_InitialState.objectReferenceValue as AIState)
        #indexPopup as int = 0
        state = (m_InitialState.objectReferenceValue as AIState)
        
        statesList as List[of string] = List[of string]()
        states as (AIState) = fsm.GetAllStates()
        
        #__currentIndex as int = 0

        for i in range(0, fsm.stateCount):
            if state.name == states[i].name:
                indexPopup = i
            statesList.Add(states[i].name)
        
        #GUILayout.Label('Initial State:')
        indexPopup = EditorGUILayout.Popup('Initial State:', indexPopup, statesList.ToArray())
        
        #if __index != __currentIndex:
            #__currentIndex = __index
            #Debug.Log(__currentIndex)
        m_InitialState.objectReferenceValue = states[indexPopup]
        #m_Object.ApplyModifiedProperties()
