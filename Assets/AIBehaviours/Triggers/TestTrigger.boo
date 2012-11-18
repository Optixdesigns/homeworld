import UnityEngine

[System.Serializable]
class TestTrigger(AITrigger):
    protected override def Init(fsm as AIBehaviours):
        pass

    protected override def Evaluate(fsm as AIBehaviours):
        return false