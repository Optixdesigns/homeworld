#import System
#import System.IO
#import System.Text.RegularExpressions
import UnityEngine
#import System.Collections.Generic
#import System.Globalization


#[AddComponentMenu('AIBehaviors')]
#[System.Serializable]
[AddComponentMenu('Neworld/AIBehaviours')]
public class AIBehaviours(MonoBehaviour):

    #public AIStates as List[of AIState] = List[of AIState]()
    #public AITriggers as List[of AITrigger] = List[of AITrigger]()
    #public states as List[of AIState] = List[typeof(AIState)](AIState)
    #private states as Dictionary[of AIState, AIState] = Dictionary[of AIState, AIState]()
    #public triggers as List[of AITrigger]
    /*
    public enum StateID:
        Monoscopic
        Red
        Cyan
        Green
        Magenta

    [System.Serializable]
    public class Storage:
        public stateID as string
        public state as AIState
    */
    #public Dictionary<Material, Dictionary<ShaderType, Shader>> 
    #public states as Dictionary[of string, AIState]
    #public statesArray as Storage


    /// This is the state the AI is in once the game is playing.
    public initialState as AIState
    /// This is the state the AI is currently in (Read Only).
    public currentState as AIState
    /// An array of all the states that belong to this AI.
    public states as (AIState) = array(AIState, 0)
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


#[System.Serializable]
public abstract class AITrigger(MonoBehaviour):
    public virtual def Evaluate(fsm as AIBehaviours):
        pass
