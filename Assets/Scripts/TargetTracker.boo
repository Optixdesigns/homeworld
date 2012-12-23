import UnityEngine

#enum radiusShape:


class TargetTracker(MonoBehaviour):
    public numberOfTargets as int = 1
    #private targetList as (Targetable) = array(Targetable, 0)
    #public targetLaters as int

    #private static _cachedDetectableObjects as Dictionary[of Collider, Detectable] = Dictionary[of Collider, Detectable]()
    [SerializeField]
    public layersChecked as LayerMask

    public perimeter as Perimeter:
        get
        private set

    def Awake ():
        InitPerimeter()
    
    def Update ():
        pass

    def InitPerimeter():
        // Setup the perimiter object
        perimeter = GameObject.CreatePrimitive(PrimitiveType.Sphere)
        perimeter.name = "Radar Perimeter"
        perimeter.tag = "Perimeter"
        perimeter.transform.parent = transform
        perimeter.renderer.enabled = false
        perimeter.AddComponent[of Perimeter]
        perimeter.targetTracker = self

    private def OnDrawGizmos():
        // Draw perimiter in editor
        if perimeter.drawGizmo:
            pos = transform.position
            Gizmos.color = Color.cyan
            Gizmos.DrawWireSphere(pos, perimeter.range)