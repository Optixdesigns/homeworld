

[System.Serializable]
class AIIdleState(AIState):
    private unit as Unit
    [SerializeField]
    public test as string = "ahoi"

    protected override def Init(fsm as AIBehaviours):
        pass
        #unit = fsm.gameObject.GetComponent(typeof(Unit))

    protected override def Reason(fsm as AIBehaviours):
        return true

    protected override def Action(fsm as AIBehaviours):
        pass
        #Debug.Log("idle")
        #controls = fsm.gameObject.GetComponent(typeof(ShipControls))
        #controls.Thrust(0.1)
        #controls.Turn(0.01)
        
        #pass

    protected override def StateEnded(fsm as AIBehaviours):
        pass

    public override def DrawGizmosSelected(fsm as AIBehaviours):
        pass

    public override def OnInspectorGUI():
        pass

    #protected override def OnDrawGizmosSelected(fsm as AIBehaviours):
        #pass

