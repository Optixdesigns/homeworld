import UnityEngine


[System.Serializable]
class AIAttackState(AIState): 
    public attackPattern as AttackPattern
    private unit as Unit
    [SerializeField]
    public target as Transform

    protected override def Init(fsm as AIBehaviours):
        // Setup attack pattern
        unit = fsm.gameObject.GetComponent(typeof(Unit))
        attackPattern = unit.GetComponent(typeof(AttackPattern))
        attackPattern.unit = unit
        attackPattern.enabled = false

    protected override def Reason(fsm as AIBehaviours):
        if not unit.target:
            return false

        return true    

    protected override def Action(fsm as AIBehaviours):
        attackPattern.enabled = true

        #Gizmos.color = Color.red
        #Gizmos.DrawLine(unit.transform.position, unit.transform.position)
        // Get the unit
        #unit = fsm.gameObject.GetComponent(typeof(Unit))
        // Execute attack pattern
        #Debug.Log(attackPattern)
        #if attackPattern: 
            #attackPattern.Update(unit)
        #Debug.Log("Attacking: " + _ship.target.transform.position  +  fsm.gameObject.transform.position)

        // Rotate around target
        #fsm.gameObject.transform.RotateAround(_ship.target.transform.position, Vector3.up, 10 * Time.deltaTime)
        #scriptWithAttackMethod.SendMessage(methodName, new AIBehaviors_AttackData(attackDamage))
        #_unit.baseProperties.attackPattern.Update()

        #_unit = fsm.gameObject.GetComponent(typeof(Ship))

        // Shoot
        #if _ship.weapons:   // Check if have a weapon system
            #_ship.weapons.Shoot()

    protected override def StateEnded(fsm as AIBehaviours):
        attackPattern.enabled = false

    protected override def DrawStateInspectorEditor(m_Object as SerializedObject, fsm as AIBehaviours):
        #script = (target cast AIAttackState)
        #script.target = PGEditorUtils.ObjectField[of Transform]("Emitter (Optional)", script.target)
        pass
        #pass
        // === Attack Method === //
        #utils = Utils()
        #utils._ListScriptObjects()
        /*
        scripts = Resources.FindObjectsOfTypeAll(typeof(AttackPattern))
        for script as UnityEngine.Object in scripts:
            #Debug.Log(script.GetType())
            if script.GetType().Equals(typeof(AttackPattern)):
                #AllScripts.Add(script.name, script as AttackPattern)
                Debug.Log(script.name)
        */
        

        #Debug.Log(AllScripts.Count.ToString())
        /*
        GUILayout.Label("Attack Method:", EditorStyles.boldLabel)

        Component[] components = GetAttackMethodComponents(stateMachine.gameObject)
        int selectedComponent as int = -1, newSelectedComponent = 0

        if ( components.Length > 0 )
        {
            string[] componentNames = GetAttackMethodComponentNames(components);

            for ( int i = 0; i < components.Length; i++ )
            {
                if ( components[i] == scriptWithAttackMethod )
                {
                    selectedComponent = i;
                    break;
                }
            }

            newSelectedComponent = EditorGUILayout.Popup(selectedComponent, componentNames);

            if ( selectedComponent != newSelectedComponent )
            {
                m_property = m_State.FindProperty("scriptWithAttackMethod");
                m_property.objectReferenceValue = components[newSelectedComponent];
            }
        }
        else
        {
            AIBehaviorsCodeSampleGUI.Draw(typeof(AIBehaviors_AttackData), "attackData", "OnAttack");
        }
        */


    /*
    def OnTriggerEnter(other as Collider):
        print("collision")
        Debug.Log("collision")
        #_ship.behaviours.ChangeState(_ship.behaviours.behaviourOnIdle)
        #Destroy(other.gameObject)
    */


