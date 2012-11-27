import UnityEngine


class RotationAttackPattern(AttackPattern): 
    def Start():
        pass
    
    def Update():
        unit.transform.RotateAround(unit.target.transform.position, Vector3.up, 10 * Time.deltaTime)

