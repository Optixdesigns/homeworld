import UnityEngine


class RotationAttackPattern(AttackPattern): 
    override def Start(unit as Unit):
        pass
    
    override def Update(unit as Unit):
        unit.transform.RotateAround(unit.target.transform.position, Vector3.up, 10 * Time.deltaTime)

