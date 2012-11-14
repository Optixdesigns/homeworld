import UnityEngine
import System.Collections
import UnityEditor


public class AIKeyUpTrigger(AITrigger):

    public keycode as KeyCode = KeyCode.E

    #protected override def Init():
    #pass

    protected override def Evaluate(fsm as AIBehaviours) as bool:
        // Logic here, return true if the trigger was triggered
        if Input.GetKeyUp(keycode):
            fsm.ChangeActiveState(transitionState)
            return true
        
        return false
    /*
    public override void DrawInspectorProperties(SerializedObject sObject):
        pass
    */