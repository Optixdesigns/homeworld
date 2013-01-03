import UnityEditor
import UnityEngine
import System.Collections
#import PGEditorUtils


[CustomEditor(typeof(Projectile))]
public class ProjectileInspector(Editor):

    // The main foldout state
    public expandEffects = true

    public override def OnInspectorGUI():
        script = (target cast Projectile)
        
        PGEditorUtils.LookLikeControls()
        content as GUIContent
        EditorGUI.indentLevel = 1
        
        self.expandEffects = PGEditorUtils.SerializedObjFoldOutList[of HitEffectGUIBacker]('EffectOnTargets   (May be inherited)', script._effectsOnTarget, self.expandEffects, script._editorListItemStates, true)
        
        GUILayout.Space(4)
        #script.debugLevel = (EditorGUILayout.EnumPopup('Debug Level', (script.debugLevel cast System.Enum)) cast DEBUG_LEVELS)
        
        // Flag Unity to save the changes to to the prefab to disk
        if GUI.changed:
            EditorUtility.SetDirty(target)

