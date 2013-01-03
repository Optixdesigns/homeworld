import UnityEngine


class RotationAttackPattern(AttackPattern): 
    def Update():
        unit.transform.RotateAround(unit.target.transform.position, Vector3.up, 10 * Time.deltaTime)

