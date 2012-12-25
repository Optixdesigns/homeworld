import UnityEngine

class Selectable(MonoBehaviour):
    public isSelected as bool = false   // Object is currently selected
    public isSelectable as bool = false // Selectable object
    public radius as single = 50
    public drawGizmo as bool = false

    private selectableBox as GameObject

    def Awake():
        // Setup collision sphere
        selectableBox = GameObject.CreatePrimitive(PrimitiveType.Sphere)
        selectableBox.name = "Selectable Collider"
        selectableBox.tag = "Selectable"
        selectableBox.transform.parent = transform
        selectableBox.transform.position = transform.position
        selectableBox.renderer.enabled = false
        (selectableBox.collider as SphereCollider).radius = self.radius

    private def OnDrawGizmos():
        // Draw perimiter in editor
        if self.drawGizmo:
            pos = transform.position
            Gizmos.color = Color.cyan
            Gizmos.DrawWireSphere(pos, self.radius)