import UnityEngine

class UICursors(MonoBehaviour):
	public attackCursor as CursorData

	def Start ():
		pass
	
	def Update ():
		pass

[System.Serializable]
class CursorData():
    public name as string
    public texture as Texture2D
    public cursorMode as CursorMode = CursorMode.Auto
    public hotSpot as Vector2
