import UnityEngine

// UI For spaceobjects
[AddComponentMenu("Neworld/Unit UI")]
class UIUnit(MonoBehaviour):
   # public unit as GameObject
    private unit as Unit

    /// MAKE THIS SEPERATE CURSOR CLASS
    public cursor as Texture2D
    public cursorAttackTexture as Texture2D
    public cursorMode as CursorMode = CursorMode.Auto
    public hotSpot as Vector2
    public showHealthbar as bool = true

    private draw as bool = false
    private selectBox as GameObject

    def Awake():
        unit = gameObject.GetComponent[of Unit]()

        // Setup selectionbox
        _CreateSelectBox()
    
    def Update():
        #select = true
        if unit.select.isSelected:
            draw = true
        else:
            draw = false    

    def _CreateSelectBox():
        selectBox = GameObject.CreatePrimitive(PrimitiveType.Cube)
        selectBox.renderer.enabled = false
        selectBox.name = "SelectionBox"
        selectBox.transform.parent = unit.transform
        selectBox.transform.position = unit.transform.position
        selectBox.transform.localScale += Vector3(1, 1, 1)

        // Create and add material
        selectBox.renderer.material = Material(Shader.Find("Transparent/Diffuse"))
        selectBox.renderer.material.color = Color.blue
        selectBox.renderer.material.color.a = 0.1

        // No need for a colldier
        Destroy(selectBox.collider)

    def OnGUI():
        if draw and unit.health and showHealthbar:
            DrawHealthBar()

        DrawSelectionBox()

    def DrawHealthBar():
        screenPosition as Vector3 = Camera.main.WorldToScreenPoint(unit.transform.position) // gets screen position.
        screenPosition.y = Screen.height - (screenPosition.y + 1) // inverts y
        GUI.HorizontalScrollbar(Rect(screenPosition.x - 50, screenPosition.y - 12, 100, 24), 0, unit.health.health, 0, 100)

    def DrawSelectionBox():
        if draw:
            selectBox.renderer.enabled = true
        else:
            selectBox.renderer.enabled = false

    def OnMouseEnter():
        #Debug.Log(unitController.isEnemy)
        if unit.isEnemy:
            cursors = GameObject.Find("GameManager").GetComponent(UICursors)
            Cursor.SetCursor(cursors.attackCursor.texture, cursors.attackCursor.hotSpot, cursors.attackCursor.cursorMode)

    def OnMouseExit():
        Cursor.SetCursor(null, Vector2.zero, cursorMode)