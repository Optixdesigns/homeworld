import UnityEditor
#import UnityEngine
#import System
#import System.Collections.Generic
#import System.Reflection

#http://docs.unity3d.com/Documentation/ScriptReference/EditorWindow.OnSelectionChange.html

public class UnitBuilder(EditorWindow):
	private previewTexture as Texture2D =  Texture2D(128, 128)
	public health as HealthModule
	
	[MenuItem('Window/Unit Builder')]
	private static def Init():
		// Get existing open window, or make new one if none
		GetWindow(UnitBuilder)
		#window.Show()

	def OnSelectionChange():
		target = Selection.activeGameObject
		#health = target.GetComponents[of HealthModule]
		#Debug.Log(target)
		#if target:
			#Debug.Log(AssetPreview.GetAssetPreview(target))
			#previewTexture = EditorUtility.GetAssetPreview(target)

		Repaint()

		#DiscoverMethods();
	
	private def OnGUI():
		EditorGUILayout.BeginHorizontal()
		#health = EditorGUILayout.ObjectField(health, HealthModule)
		#methodIndex = EditorGUILayout.Popup(popupLabel, methodIndex, methodLabels);
		#name = EditorGUILayout.TextField ("Unit Name", myString)
		#Debug.Log(previewTexture)
		if previewTexture:
			EditorGUI.DrawPreviewTexture(Rect(25,60,100,100), previewTexture)

	#def RenderHealthModule
	#private def GetHealthModules():
		#methods = List[of HealthModule]()
		#methodLabels = new List<GUIContent>();


