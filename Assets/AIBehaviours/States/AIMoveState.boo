

[System.Serializable]
class AIMoveState(AIState): 
    private _unit as Unit
    [SerializeField]
    public test as int

    protected override def Init(fsm as AIBehaviours):
        pass

    protected override def Reason(fsm as AIBehaviours):
        return true

    protected override def StateEnded(fsm as AIBehaviours):
        pass

    protected override def Action(fsm as AIBehaviours):
        pass

    public override def DrawGizmosSelected(fsm as AIBehaviours):
        pass

    public override def DrawStateInspectorGUI(m_State as SerializedObject):
        m_property = m_State.FindProperty("test")
        EditorGUILayout.PropertyField(m_property)
        #script = (target cast AIMoveState)
        #SerializedObject m_Object = SerializedObject(self)
        #self.test = EditorGUILayout.IntSlider("IntField", self.test, 0, 10)
        #test.ApplyModifiedProperties()
        #m_State.ApplyModifiedProperties();
        /*
        #moveToPosition = ship.moveToPosition + ship.damageAttribute.range // Stay at perfect damage range
        moveDir as Vector3 = (_ship.moveToPosition - _ship.gameObject.transform.position)
        #print(_ship.moveToPosition)
        #print(_ship.gameObject.transform.position)
        
        // Rotate towards the waypoint
        _ship.gameObject.transform.rotation = Quaternion.Slerp(_ship.gameObject.transform.rotation, Quaternion.LookRotation(moveDir), (_ship.baseProperties.maxRotate * Time.deltaTime))
        _ship.gameObject.transform.eulerAngles = Vector3(0, _ship.gameObject.transform.eulerAngles.y, 0)
        
        // Calculate velocity
        velocity = (moveDir.normalized * _ship.baseProperties.maxVelocity)
        
        // Apply the new Velocity
        _ship.gameObject.rigidbody.velocity = velocity

        # CHECK IF SOMETHING IS IN THE WAY OR ARRIVED
        if _ship.moveToPosition == _ship.gameObject.transform.position: // arrived
            _ship.behaviours.ChangeState(_ship.behaviours.behaviourOnIdle)
        */    
