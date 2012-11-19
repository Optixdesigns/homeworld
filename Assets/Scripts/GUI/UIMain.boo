import UnityEngine

/*
* Holds the main game UI
*/
/*
test as CursorSet = CursorSet()
test.name = "ATTACK"
CursorSets as (CursorSet)
CursorSets[0] = test
*/
#enum CursorSets:
    #ATTACK as CursorSet = CursorSet()

class UIMain (MonoBehaviour):
    public cursors as (CursorData) = array(CursorData, 0)

/// A Cursor set
[System.Serializable]
class CursorData():
    public name as string
    public cursorAttackTexture as Texture2D
    public cursorMode as CursorMode = CursorMode.Auto
    public hotSpot as Vector2


