import UnityEngine

class testmove (MonoBehaviour): 
    movement as MovementModule

    def Start():
        movement = GetComponent(typeof(MovementModule))

    def FixedUpdate():
        movement.moveDirection = Vector3(10, 100, 10)

    def OnDrawGizmos():
        Gizmos.DrawLine(transform.position, movement.moveDirection)