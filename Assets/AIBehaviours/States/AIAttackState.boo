import UnityEngine


[System.Serializable]
class AIAttackState(AIState):
    [SerializeField]
    public attackPattern as AttackPattern
    [SerializeField]
    public target as Transform

    #private unit as Unit

    protected override def Init(fsm as AIBehaviours):
        // Setup attack pattern
        if self.attackPattern and self.target:
            self.attackPattern.enabled = true

    protected override def Reason(fsm as AIBehaviours):
        // No target so we dont run
        if not self.target:
            return false

        return true    

    protected override def Action(fsm as AIBehaviours):
        self.attackPattern.enabled = true

    protected override def StateEnded(fsm as AIBehaviours):
        self.attackPattern.enabled = false
        self.target = null

    public override def DrawStateInspectorGUI(m_State as SerializedObject):
        m_property = m_State.FindProperty("attackPattern")
        EditorGUILayout.PropertyField(m_property)
        m_property = m_State.FindProperty("target")
        EditorGUILayout.PropertyField(m_property)



