import UnityEngine

[System.Serializable]
class AIIdleState(AIState):
    protected override def Reason(fsm as AIBehaviours):
        return true

    protected override def Action(fsm as AIBehaviours):
        pass

    protected override def StateEnded(fsm as AIBehaviours):
        pass
