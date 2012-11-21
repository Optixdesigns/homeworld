#import System
#import System.Collections
#import System.Collections.Generic
import UnityEngine
import UnityEditor


public class AIBehavioursTriggersGUI:
    #toggle as Dictionary[of int, bool] = Dictionary[of int, bool]()

    public static def InitNewTriggers(state as AIState, fsm as AIBehaviours):
        #triggersDictionary as Dictionary[of string, Type] = Dictionary[of string, Type]()
        triggersList as List[of AITrigger] = List[of AITrigger]()
   
        // Setup a dictionary of the default triggers
        #triggersDictionary['Test'] = typeof(TestTrigger)
        /*
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
        */
        state.ReplaceAllTriggers(triggersList.ToArray())

    public static def Draw(state as AIState, fsm as AIBehaviours):
        triggers as (AITrigger) = state.GetAllTriggers()

        if triggers.Length == 0:
            InitNewTriggers(state, fsm)
        
        for i in range(0, triggers.Length):
            sObject = SerializedObject(triggers[i])
            mProp as SerializedProperty = sObject.FindProperty('name')
            GUILayout.Label(mProp.stringValue)

            #toggle[i] = EditorGUILayout.Foldout(toggle[i], states[i].name)
            #if EditorGUILayout.Toggle(states[i].isEnabled, GUILayout.Height(20)) != states[i].isEnabled:
                #states[i].isEnabled = (not states[i].isEnabled)
            